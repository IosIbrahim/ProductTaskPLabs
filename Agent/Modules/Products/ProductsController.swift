//
//  ProductsController.swift
//  Agent
//
//  Created by Ibrahim on 21/11/2024.
//

import UIKit
import RxSwift
import RxRelay

class ProductsController: ViewController {
    
    @IBOutlet weak var lblResults: UILabel!
    @IBOutlet weak var clcFilter: UICollectionView!
    @IBOutlet weak var tblProducts: UITableView!
    
    // MARK: - VARIABLE
    private var dataSource = [ProductModel]()
    @Disposed var disposer: Disposer
    private let viewmodel = ProductViewModel()
    private let filterItems = ["Beauty","Fragrances"]
    private var selectIndex:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsViewModelStatus()
        clcFilter.register(FilterCell.self)
        tblProducts.register(ProductCell.self)
        viewmodel.getProducts()
        tblProducts.createRefresher()
        tblProducts.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }

    // MARK: - FUNCTION
    func productsViewModelStatus() {
        viewmodel.status
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] state in
                    guard let self = self else { return }
                    switch state {
                        case .error(let message):
                            print(message)
                            let mass = message
                            runOnMainThread {
                                self.toastBar.show(with: mass)
                            }
                      //  case .loading:self.showIndicator()
                        case .products(let items):
                          //  self.stopAnimating()
                            self.dataSource.append(contentsOf: items)
                            runOnMainThread {
                                self.lblResults.text = "\(self.dataSource.count) Results"
                                self.tblProducts.reloadData()
                                self.tblProducts.refreshControl?.endRefreshing()
                            }
                        default: break
                    }
                }
        ).disposed(by: disposer)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        dataSource.removeAll()
        runOnMainThread {
            self.lblResults.text = "\(self.dataSource.count) Results"
            self.tblProducts.reloadData()
        }
        viewmodel.reloadData()
    }

}

// MARK: - TABLEVIEW DELEGADE DATASOURCE

extension ProductsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ProductCell
        cell.selectionStyle = .none
        let item = dataSource[indexPath.row]
        cell.drawCell(item)
        if indexPath.row == dataSource.count - 1 {
            viewmodel.getProducts()
        }
        return cell
        
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainCoordinator.public?.move(to: .details(dataSource[indexPath.row]))
    }
}


// MARK: - COLLECTION DataSource & Delegade

extension ProductsController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(FilterCell.self, for: indexPath)
        let model = filterItems[indexPath.row]
        cell.drawCell(model, selected: selectIndex == indexPath.row)
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = ((collectionView.frame.width - 20) / 3) // 15 because of paddings
        if isIPAD() {
            width = ((collectionView.frame.width - 20) / 7)
        }
        return CGSize(width: width, height: collectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataSource.removeAll()
        runOnMainThread {
            self.tblProducts.reloadData()
        }
        if selectIndex ==  indexPath.row {
            selectIndex = -1
            viewmodel.filterProducts("")
        }else {
            selectIndex = indexPath.row
            viewmodel.filterProducts(filterItems[indexPath.row])
        }
        runOnMainThread {
            self.clcFilter.reloadData()
        }
    }
}

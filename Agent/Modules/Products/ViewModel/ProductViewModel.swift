//
//  ProductViewModel.swift
//  Agent
//
//  Created by Ibrahim on 21/11/2024.
//

import Foundation
import RxSwift
import RxRelay

class ProductViewModel {
    @Disposed private var disposer: Disposer
    let status = PublishRelay<State>()
    private var limit: Int = .zero
    private var isFetching:Bool = true
    private var products = [ProductModel]()
    private var filterCat: String = ""
    
    enum State {
        case error(String)
        case loading
        case products([ProductModel])
    }
    
    func getProducts() {
        let skip = limit
        if isFetching {
            limit += 10
            isFetching = false
            status.accept(.loading)
        }else {
            return
        }
        let url = "\(EndPoints.product.rawValue)\(limit)&skip=\(skip)"
        AFNetwork.shared.get(url: url,headers: nil, type: ProductsResponseModel.self) {error, response in
            if let model = response {
                print(model)
                if self.limit < model.total ?? .zero {
                    self.isFetching = true
                }
                self.products.append(contentsOf: model.products ?? [])
                self.filterProducts(self.filterCat)
            }else {
                print(error?.localizedDescription ?? "")
                self.status.accept(.error(error?.localizedDescription ?? .empty))
            }
        }
    }
    
    func reloadData() {
        limit = .zero
        isFetching = true
        self.getProducts()
    }
    
    func filterProducts(_ filter:String) {
        var filtered = [ProductModel]()
        self.filterCat = filter
        for item in products {
            if item.category?.lowercased() == filter.lowercased() {
                filtered.append(item)
            }
        }
        if filter.isEmpty {
            self.status.accept(.products(products))
        }else {
            self.status.accept(.products(filtered))

        }
    }
}

//
//  DetailsController.swift
//  Agent
//
//  Created by Ibrahim on 23/11/2024.
//

import UIKit
import ImageSlideshow

class DetailsController: ViewController,Sharable {

    @IBOutlet weak var lblPayment: SubTitleLBL!
    @IBOutlet weak var lblDes: SubTitleLBL!
    @IBOutlet weak var lblReturn: SubTitleLBL!
    @IBOutlet weak var lblWarenty: InFoLBL!
    @IBOutlet weak var lblInStock: InFoLBL!
    @IBOutlet weak var lblSale: SubTitleLBL!
    @IBOutlet weak var lblPrice: SubTitleLBL!
    @IBOutlet weak var imgSlider: ImageSlideshow!
    @IBOutlet weak var lblSku: SubTitleLBL!
    @IBOutlet weak var lblName: SubTitleLBL!
    @IBOutlet weak var lblCategory: SubTitleLBL!
    @IBOutlet weak var lblTitle: TitleLBL!
    
    var product:ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawProduct()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backOnTap(_ sender: Any) {
        MainCoordinator.public?.move(to: .pop)
    }
    
    @IBAction func shareOnTap(_ sender: Any) {
        self.share([self.product?.meta?.qr ?? .empty])
    }
    
    
    private func drawProduct() {
        setSlider()
        lblTitle.text = product?.title
        lblCategory.text = product?.category
        lblSku.text = "SKU: \(product?.sku ?? "")"
        
        lblPrice.text = "EGP \(product?.price ?? .zero)"
        let sale = "EGP  \(product?.discountPercentage ?? .zero)"
        let underlineAttribute = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: sale, attributes: underlineAttribute)
        lblSale.attributedText = underlineAttributedString
        
        lblInStock.text = product?.availabilityStatus
        lblWarenty.text = product?.warrantyInformation
        lblPayment.text = "Cash Or Card \n Payment"
        lblReturn.text = product?.returnPolicy
        lblDes.text = product?.description
        
    }
    
    private func setSlider() {
        var sliders = [SDWebImageSource]()
        for img in product?.images ?? [] {
            let afNetworkingSource = SDWebImageSource(urlString: img)!
            sliders.append(afNetworkingSource)
        }
        imgSlider.slideshowInterval = 5.0
        imgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imgSlider.contentScaleMode = UIViewContentMode.scaleAspectFit
        imgSlider.pageIndicator = UIPageControl.withSlideshowColors()
        imgSlider.activityIndicator = DefaultActivityIndicator()
        imgSlider.setImageInputs(sliders)
        imgSlider.corners()
    }

    

}

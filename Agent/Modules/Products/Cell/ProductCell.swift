//
//  ProductCell.swift
//  Agent
//
//  Created by Ibrahim on 21/11/2024.
//

import UIKit
import ImageSlideshow
import Locality
import Simplebest

class ProductCell: UITableViewCell {

    @IBOutlet weak var ratePicker: RateControl!
    @IBOutlet weak var lblName: InFoLBL!
    @IBOutlet weak var lblSale: SubTitleLBL!
    @IBOutlet weak var stkSale: UIStackView!
    @IBOutlet weak var lblPrice: SubTitleLBL!
    @IBOutlet weak var lblCategory: InFoLBL!
    @IBOutlet weak var slider: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCell(_ item:ProductModel) {
        var sliders = [SDWebImageSource]()
        for img in item.images ?? [] {
            let afNetworkingSource = SDWebImageSource(urlString: img)!
            sliders.append(afNetworkingSource)
        }
        slider.slideshowInterval = 5.0
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slider.contentScaleMode = UIViewContentMode.scaleAspectFit
        slider.pageIndicator = UIPageControl.withSlideshowColors()
        slider.activityIndicator = DefaultActivityIndicator()
        slider.setImageInputs(sliders)

        lblName.text = item.title
        lblPrice.text = "EGP \(item.price ?? .zero)"
        lblCategory.text = item.category
        ratePicker.rating = Double(item.rating ?? 0)
        let sale = "EGP  \(item.discountPercentage ?? .zero)"
        let underlineAttribute = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: sale, attributes: underlineAttribute)
        lblSale.attributedText = underlineAttributedString
    }
}

extension UIPageControl: PageIndicatorView {
    public var view: UIView {
        return self
    }

    public var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }

    open override func sizeToFit() {
        var frame = self.frame
        frame.size = size(forNumberOfPages: numberOfPages)
        frame.size.height = 30
        self.frame = frame
    }

    public static func withSlideshowColors() -> UIPageControl {
        let pageControl = UIPageControl()

        if #available(iOS 13.0, *) {
            pageControl.currentPageIndicatorTintColor = UIColor { traits in
                traits.userInterfaceStyle == .dark ? .white : .lightGray
            }
        } else {
            pageControl.currentPageIndicatorTintColor = .lightGray
        }
        
        if #available(iOS 13.0, *) {
            pageControl.pageIndicatorTintColor = UIColor { traits in
                traits.userInterfaceStyle == .dark ? .systemGray : .black
            }
        } else {
            pageControl.pageIndicatorTintColor = .black
        }

        return pageControl
    }
}

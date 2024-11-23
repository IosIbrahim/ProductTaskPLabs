//
//  ImageView.swift
//  Agent
//
//  Created by Ibrahim Sabry on 13/02/2023.
//

import Foundation
import Foundation
import UIKit
import Kingfisher
import Viewity

class RoundImage: UIImageView {
       
    override func awakeFromNib() {
        self.corners(self.midHeight,style: .all)
        self.border(width: 1, color: .enabledButtonColor)
    }
}

class UserImage: UIImageView {
       
    override func awakeFromNib() {
        self.corners(self.midHeight,style: .all)
        self.border(width: 1, color: .white)
    }
}

class GoImage: UIImageView {
    override func awakeFromNib() {
        if Language.isArabic() {
            transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}

extension UIImageView {
    func loadImageWithoutCash(_ url:String,placeHoder: String = "ic-user") {
        self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeHoder),options: [.fromMemoryCacheOrRefresh,.cacheMemoryOnly])
    }
}

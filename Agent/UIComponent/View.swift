//
//  View.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit
import Viewity
import Cosmos

final class RateControl: CosmosView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        settings.emptyImage = UIImage(named: "ic-emptyStar")
        settings.filledImage = UIImage(named: "ic-filledStar")
        settings.fillMode = .half
        semanticContentAttribute = .spatial
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }

}

class UpCornerView: UIView {
    override func awakeFromNib() {
        corners(15,style: .all)
        shadow(offset: .zero, color: R.color.appShadow() ?? .gray, radius: 15, opacity: 0.4)
    }
}

class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable var addShadow:Bool = true{

            didSet(newValue) {
                if(newValue == true){
                    self.layer.masksToBounds = false
                    self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowOffset = CGSize(width: 2, height: 3)
                    self.layer.shadowRadius = 12
                    self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                    self.layer.shouldRasterize = true
                    self.layer.rasterizationScale =  UIScreen.main.scale
                    print("trying to use shadow")
                }
            }

        }
}

class BottomHomeCornerView: UIView {
    override func awakeFromNib() {
        corners(15,style: .downRight)
    }
}

class BottomCornerView: UIView {
    override func awakeFromNib() {
        corners(15,style: .down)
    }
}

class LineView: UIView {
    override func awakeFromNib() {
        corners(15,style: .up)
        backgroundColor = .appLine
    }
}


class HomeView: UIView {
    override func awakeFromNib() {
        corners(12,style: .all)
        backgroundColor = .white
        shadow(offset: .zero, color: .black, radius: 12, opacity: 0.1)
    }
}

class FilterView: UIView {
    override func awakeFromNib() {
        corners(self.midHeight,style: .all)
        backgroundColor = .white
    }
}

class StatusView: UIView {
    override func awakeFromNib() {
        corners(5,style: .all)
    }
}

class StatusNotificationView: UIView {
    override func awakeFromNib() {
        corners(2,style: .all)
    }
}

class BorderView: UIView {
    override func awakeFromNib() {
        corners(self.midHeight,style: .all)
        border(width: 1, color: .enabledButtonColor)
    }
}

class MessagesView: UIView {
    override func awakeFromNib() {
        corners(15,style: .all)
       // backgroundColor = Colors.appMain()
    }
}

class HomeFilterView: UIView {
    override func awakeFromNib() {
        corners(5,style: .all)
        backgroundColor = .white
        shadow(offset: .zero, color: .black, radius: 5, opacity: 0.1)
    }
}

extension UIView {
    func setTransform() {
        transform = CGAffineTransform(scaleX: -1, y: 1)
    }
}

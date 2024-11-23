//
//  Label.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit

class TitleLBL: UILabel {
    override func awakeFromNib() {
        setBoldFont(.s20)
    }
}

class BoldLBL: UILabel {
    override func awakeFromNib() {
        setBoldFont(.s18)
    }
}

class SubTitleLBL: UILabel {
    override func awakeFromNib() {
        setSemiBoldFont(.s15)
    }
}

class InFoLBL: UILabel {
    override func awakeFromNib() {
        setRegularFont(.s15)
    }
}

class SubIfoLBL: UILabel {
    override func awakeFromNib() {
        setRegularFont(.s12)
    }
}

class PriceLBL: UILabel {
    override func awakeFromNib() {
        setBoldFont(.s34)
    }
}

extension UILabel {
    func  setRegularFont(_ size:FontStyle.Size) {
        font = FontStyle.shared.setRegularFont(size)
    }
    
    func  setSemiBoldFont(_ size:FontStyle.Size) {
        font = FontStyle.shared.setSemiBoldFont(size)
    }
    
    func  setBoldFont(_ size:FontStyle.Size) {
        font = FontStyle.shared.setBoldFont(size)
    }
    
    func setLanguageFont(_ size:FontStyle.Size){
        font = FontStyle.shared.setLanguageFont(size)
    }
    
    func setLTR() {
        textAlignment = Language.isArabic() ? .right:.left
    }
    
    func setRTL() {
        textAlignment = Language.isArabic() ? .left:.right
    }
    
    func setCenter() {
        textAlignment = .center
    }
    
    func underlineLbl(text: String) {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: text, attributes: underlineAttribute)
        self.attributedText = underlineAttributedString
    }
    
    func title(_ title:String) {
        text = title
    }
}



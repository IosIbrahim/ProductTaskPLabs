//
//  TexField.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit

class LeftTXF: UITextField {
    override func awakeFromNib() {
        setSemiBoldFont(.s15)
        setLTR()
    //    self.placeHolderColor = self.placeHolderColor
    }
}

class RightTXF: UITextField {
    override func awakeFromNib() {
        setSemiBoldFont(.s15)
        setLTR()
    }
}

class PriceTXF: UITextField {
    override func awakeFromNib() {
        setBoldFont(.s20)
        setRTL()
    }
}

class CenterTXF: UITextField {
    override func awakeFromNib() {
        setSemiBoldFont(.s15)
        setCenter()
    }
}

extension UITextField {
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
    
    func setPlaceHolder(_ place:String) {
        self.attributedPlaceholder = NSAttributedString(
            string: place,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLblColor]
        )
    }
    
    func text(_ title:String) {
        text = title
    }
    
    func placeHolder(_ title:String) {
        placeholder = title
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
            get {
                return self.placeHolderColor
            }
            set {
                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder ?? "" : "", attributes:[NSAttributedString.Key.foregroundColor: newValue ?? .appLine])
            }
    }
}



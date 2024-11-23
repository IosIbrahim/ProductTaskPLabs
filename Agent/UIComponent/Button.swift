//
//  Button.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit
import Viewity

class MainBTN: UIButton {
    override func awakeFromNib() {
        setBoldFont(.s15)
        disAbleBTN()
        setTitleColor(.white, for: .normal)
        tintColor = .white
        corners(10,style: .all)
    }
    
    func enableBTN() {
        tintColor = .white
        backgroundColor = .enabledButtonColor
        isEnabled = true
    }
    
    func disAbleBTN() {
        tintColor = .white
        backgroundColor = .disabledButtonColor
        isEnabled = false
    }
}

class NormalBTN: UIButton {
    override func awakeFromNib() {
        setSemiBoldFont(.s15)
    }
}

class AddBTN: UIButton {
    override func awakeFromNib() {
        setBoldFont(.s24)
        corners(self.midHeight,style: .all)
        border(width: 3, color: Colors.appBlue() ?? .blue)
        backgroundColor = Colors.appBlueLight()
        
    }
}

class LanguaeBTN: UIButton {
    override func awakeFromNib() {
        setLanguageFont(.s15)
        corners(self.midHeight,style: .all)
        border(width: 1, color: .enabledButtonColor)
    }
}

class BackBTN: NormalBTN {
    override func awakeFromNib() {
        if Language.isArabic() {
            setTransform()
        }
        self.text("")
    }
}

extension UIButton {
    func  setRegularFont(_ size:FontStyle.Size) {
        titleLabel?.font = FontStyle.shared.setRegularFont(size)
    }
    
    func  setSemiBoldFont(_ size:FontStyle.Size) {
        titleLabel?.font = FontStyle.shared.setSemiBoldFont(size)
    }
    
    func  setBoldFont(_ size:FontStyle.Size) {
        titleLabel?.font = FontStyle.shared.setBoldFont(size)
    }
    
    func setLanguageFont(_ size:FontStyle.Size){
        titleLabel?.font = FontStyle.shared.setBoldFont(size)
    }
   
    func underlineBtn2(title: String) {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.font : FontStyle.shared.setSemiBoldFont(.s15),NSAttributedString.Key.foregroundColor:UIColor.enabledButtonColor] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: title, attributes: underlineAttribute)
       // self.titleLabel?.attributedText = underlineAttributedString
        self.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    
    func underlineBtn(text: String) {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: text, attributes: underlineAttribute)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
     //   self.titleLabel?.underlineLbl(text: text)
    }
    
    func text(_ title:String) {
        setTitle(title, for: .normal)
    }
    
    func icon(_ icon:UIImage?) {
        setImage(icon, for: .normal)
    }
    
}



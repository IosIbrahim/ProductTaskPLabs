//
//  FontStye.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit

class FontStyle {
    static let shared = FontStyle()
    
    enum Size: CGFloat {
        case s9 = 9.0
        case s10 = 10.0
        case s12 = 12.0
        case s13 = 13.0
        case s14 = 14.0
        case s15 = 15.0
        case s16 = 16.0
        case s18 = 18.0
        case s20 = 20.0
        case s22 = 22.0
        case s24 = 24.0
        case s34 = 34.0
        case s40 = 40.0
    }
    
    func setRegularFont(_ size:Size) -> UIFont {
        let name = Language.isArabic() ? "Tajawal-Regular":"Nunito-Regular"
        return UIFont(name: name, size:GET_RATIO(size.rawValue))!
    }
    
    func setBoldFont(_ size:Size) -> UIFont {
        let name = Language.isArabic() ? "Tajawal-Bold":"Nunito-Bold"
        return UIFont(name: name, size:GET_RATIO(size.rawValue))!
    }
    
    func setSemiBoldFont(_ size:Size) -> UIFont {
        let name = Language.isArabic() ? "Tajawal-Medium":"Nunito-SemiBold"
        return UIFont(name: name, size:GET_RATIO(size.rawValue))!
    }
    
    func setLanguageFont(_ size:Size) -> UIFont {
        let name = Language.isArabic() ? "Nunito-SemiBold":"Tajawal-Medium"
        return UIFont(name: name, size:GET_RATIO(size.rawValue))!
    }
    
    private func GET_RATIO(_ number: CGFloat) -> CGFloat {
        if isIPAD() {
            return number + 7
        }
         return number * UIScreen.main.bounds.width / 360
     }
    
}


extension UITextView {
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
}

extension UISegmentedControl {

func setFontSize() {

    let normalTextAttributes: [NSObject : AnyObject] = [
        NSAttributedString.Key.foregroundColor as NSObject: Colors.appBlack() ?? .black,
        NSAttributedString.Key.font as NSObject : FontStyle.shared.setSemiBoldFont(.s15)
    ]

    let boldTextAttributes: [NSObject : AnyObject] = [
        NSAttributedString.Key.foregroundColor as NSObject : UIColor.white,
        NSAttributedString.Key.font as NSObject : FontStyle.shared.setSemiBoldFont(.s15),
    ]

    self.setTitleTextAttributes(normalTextAttributes as? [NSAttributedString.Key : Any], for: .normal)
    self.setTitleTextAttributes(normalTextAttributes as? [NSAttributedString.Key : Any], for: .highlighted)
    self.setTitleTextAttributes(boldTextAttributes as? [NSAttributedString.Key : Any], for: .selected)
  }
}


func isIPAD() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

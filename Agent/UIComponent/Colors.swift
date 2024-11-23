//
//  Colors.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit
import Locality

extension UIColor {
    public class var backgroundColor: UIColor {
        return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
    public class var secondaryBackgroundColor: UIColor { // purple
        return UIColor(red: 0.796, green: 0.761, blue: 0.925, alpha: 1)
    }
    public class var disabledButtonColor: UIColor { // pale purple
        return UIColor(red: 0.796, green: 0.761, blue: 0.925, alpha: 1)
    }
    public class var enabledButtonColor: UIColor { // yellow
        return R.color.appYellow() ?? .yellow
    }
    public class var mainLblColor: UIColor { // purple
        return UIColor(red: 0.4, green: 0.329, blue: 0.643, alpha: 1)
    }
    public class var secondaryLblColor: UIColor { // gray
        return UIColor(red: 0.537, green: 0.553, blue: 0.608, alpha: 1)
    }
    public class var thirdLblColor: UIColor { // black
        UIColor(red: 0.286, green: 0.294, blue: 0.321, alpha: 1)
    }
    public class var forthLblColor: UIColor { // white
        UIColor.white
    }
    public class var fifthLblColor: UIColor { // green
        UIColor(red: 0.149, green: 0.718, blue: 0.204, alpha: 1)
    }
    public class var sixthLblColor: UIColor { // red
        UIColor(red: 0.941, green: 0.337, blue: 0.396, alpha: 1)
    }
    public class var notification: UIColor { // red
        UIColor(red: 1, green: 0.686, blue: 0, alpha: 1)
    }
    
    public class var ligt: UIColor { // red
        UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    public class var line: UIColor {
        UIColor(red: 0, green: 0, blue: 0.84, alpha: 1)
    }
    static var appLine: UIColor { UIColor(named: "app-line") ?? .black }
    
    public class var filtBorder: UIColor {
           UIColor.fromHex(hex: "#ECECEC")
       }
       
    public class var filterBorder: UIColor {
           UIColor.fromHex(hex: "#C2BEDC")
       }
       
    public class var filterBack: UIColor {
           UIColor.fromHex(hex: "#BDB8D4")
       }

    // MARK: - From UIColor to String

       func toHex(alpha: Bool = false) -> String? {
           guard let components = cgColor.components, components.count >= 3 else {
               return nil
           }

           let r = Float(components[0])
           let g = Float(components[1])
           let b = Float(components[2])
           var a = Float(1.0)

           if components.count >= 4 {
               a = Float(components[3])
           }

           if alpha {
               return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
           } else {
               return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
           }
       }
    
    func getRedhexa(_ ratio:Double) -> String {
        if ratio <= 1 {
            return "#3e88f6"
        }else if ratio <= 10 {
            return "#5179dd"
        }else if ratio <= 20 {
            return "#646bc4"
        }else if ratio <= 30 {
            return "#7a5ca9"
        }else if ratio <= 40 {
            return "#8b5093"
        }else if ratio <= 50 {
            return "#a14178"
        }else if ratio <= 60 {
            return "#b23663"
        }else if ratio <= 70 {
            return "#c5294a"
        }else if ratio <= 80 {
            return "#d91c32"
        }else if ratio <= 90 {
            return "#f00b14"
        }else {
            return "#ff0000"
        }
    }
    
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
          if b < 1.0 {
            let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
            return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
          } else {
            let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
            return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
          }
        }
        return self
      }
    
    class func fromHex(hex:String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}

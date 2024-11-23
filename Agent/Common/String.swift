//
//  String.swift
//  Agent
//
//  Created by ibrahim on 21/02/2023.
//

import Foundation
extension String {
    func convertArabicNumbers() -> String {
         var number = self
         number = number.replacingOccurrences(of: "٠", with: "0")
         number = number.replacingOccurrences(of: "١", with: "1")
         number = number.replacingOccurrences(of: "٢", with: "2")
         number = number.replacingOccurrences(of: "٣", with: "3")
         number = number.replacingOccurrences(of: "٤", with: "4")
         number = number.replacingOccurrences(of: "٥", with: "5")
         number = number.replacingOccurrences(of: "٦", with: "6")
         number = number.replacingOccurrences(of: "٧", with: "7")
         number = number.replacingOccurrences(of: "٨", with: "8")
         number = number.replacingOccurrences(of: "٩", with: "9")
         return number
     }
    
    func isValidAmount() -> Bool {
        let ACCEPTABLE_CHARACTERS = "0123456789."
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = self.components(separatedBy: cs).joined(separator: "")
        return self == filtered
    }
}
extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:self) ?? Date()
        return date
    }
}

extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}

extension String {
    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    func getCurrency() -> String {
        let kd = Language.isArabic() ? " دينار ":" KD"
        return "\(self) \(kd)"
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension String{
    
    
    func formateDAte(dateString:String?,formateString:String)  -> String {
        if let dateConstant = dateString
         {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm:ss"
            let stringDateMily = dateFormatterGet.date(from: dateConstant )
            if let BigDateConstan = stringDateMily
            {
                let formattedDate1 = dateFormatterGet.string(from: BigDateConstan)
                dateFormatterGet.dateFormat = formateString
                let year_month_day = dateFormatterGet.string(from: BigDateConstan)
               dateFormatterGet.dateFormat = formateString
                if Language.isArabic()
                {
                    dateFormatterGet.locale = NSLocale(localeIdentifier: "ar") as Locale
                }
                else
                {
                    dateFormatterGet.locale = NSLocale(localeIdentifier: "En") as Locale
                }

               let dayNumber = dateFormatterGet.string(from: BigDateConstan)
               return dayNumber
            }
            else{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm:ss"
               let stringDateWithoutMily = dateFormatterGet.date(from: dateConstant)
               dateFormatterGet.dateFormat = formateString
               let formattedDate1 = dateFormatterGet.string(from: stringDateWithoutMily!)
               dateFormatterGet.dateFormat = formateString
               dateFormatterGet.dateFormat = formateString
               let dayNumber = dateFormatterGet.string(from: stringDateWithoutMily!)
               dateFormatterGet.dateFormat = formateString
               let monthText = dateFormatterGet.string(from: stringDateWithoutMily!)
               return formattedDate1
            }
         }
        
        return ""
    }
}

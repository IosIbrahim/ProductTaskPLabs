//
//  Date.swift
//  Agent
//
//  Created by ibrahim on 21/02/2023.
//

import Foundation

extension Data {
    typealias bit_order_16 = (_ value: UInt16) -> UInt16
    typealias bit_order_8 = (_ value: UInt8) -> UInt8
    
    func straight_16(value: UInt16) -> UInt16 {
        return value
    }
    
    func straight_8(value: UInt8) -> UInt8 {
        return value
    }
    
    func crc16(data_order: bit_order_8, remainder_order: bit_order_16, remainder: UInt16, polynomial: UInt16) -> UInt16 {
        var remainder = remainder
        
        for byte in self {
            remainder ^= UInt16(data_order(byte)) << 8
            for _ in 0..<8 {
                if (remainder & 0x8000) != 0 {
                    remainder = (remainder << 1) ^ polynomial
                } else {
                    remainder = (remainder << 1)
                }
            }
        }
        return remainder_order(remainder)
    }
    
    func crc16ccitt() -> UInt16 {
        return crc16(data_order: straight_8, remainder_order: straight_16, remainder: 0xffff, polynomial: 0x1021)
    }
}

extension Date {
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getCurrentDate(format: String = "yyyy-MM-dd")->String {
            let dateFormatter =  DateFormatter()
            dateFormatter.calendar = Calendar(identifier:.gregorian)
            dateFormatter.dateFormat = format
            dateFormatter.locale = .current
            return dateFormatter.string(from: self).convertArabicNumbers()
    }
    
   
    func localDate() -> Date {
        let date = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date) else {return Date()}
        return localDate
    }

    func isBetween(startDate:Date, endDate:Date)->Bool
    {
        return (startDate.compare(self) == .orderedAscending || startDate.compare(self) == .orderedSame) && (endDate.compare(self) == .orderedDescending || endDate.compare(self) == .orderedSame)
    }
    
}


//
//  Calendar.swift
//  Agent
//
//  Created by Ibrahim on 17/07/2024.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        print(numberOfDays.day)
        return numberOfDays.day!
    }
}

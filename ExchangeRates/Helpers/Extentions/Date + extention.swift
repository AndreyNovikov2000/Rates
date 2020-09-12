//
//  Date + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

extension Date {
    func getDaysAgoFromCurretnDate(days: Int) -> Date {
        let daysAgo = days > 0 ? -days : days
        let today = Date()
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: daysAgo, to: today) ?? Date()
    }
    
    func getTimeFromCurretnDate(withComponent component: Calendar.Component, componentValue value: Int) -> Date {
         let today = Date()
         let calendar = Calendar.current
         return calendar.date(byAdding: component, value: value, to: today) ?? Date()
     }
}

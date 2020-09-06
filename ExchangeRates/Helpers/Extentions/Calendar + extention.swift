//
//  Calendar + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

extension Calendar {
    func getDays(fromDate: Date?, toDate: Date?) -> Int {
        guard let fromDate = fromDate, let toDate = toDate else { return 0 }
        let components = dateComponents([.day], from: fromDate, to: toDate)
        
        if let day = components.day {
            return day
        } else {
            return 0
        }
    }
    
    func getDays(fromDateString: String, toDateString: String, dateFormate: String = "YYYY-MM-dd") -> Int {
        let dateFormatrer = DateFormatter()
        dateFormatrer.dateFormat = dateFormate
        let fromDate = dateFormatrer.date(from: fromDateString)
        let toDate = dateFormatrer.date(from: toDateString)
        
        return getDays(fromDate: fromDate, toDate: toDate)
    }
}


extension Calendar {
    func getAllDates(fromDateString: String, toDateString: String, dateFormate: String = "YYYY-MM-dd") -> [String] {
        var dates = [String]()
        let numberOfDays = getDays(fromDateString: fromDateString, toDateString: toDateString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        
        guard let fromDate = dateFormatter.date(from: fromDateString) else { return dates }
        
        
        (0..<numberOfDays).forEach { (day) in
            let newDate = self.date(byAdding: .day, value: day, to: fromDate)
            if let date = newDate {
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        
        return dates
    }
    
    func getAllDates(fromDate: Date, toDate: Date, dateFormate: String = "YYYY-MM-dd") -> [String] {
        var dates = [String]()
        let numberOfDays = getDays(fromDate: fromDate, toDate: toDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        
        (1...numberOfDays).forEach { (day) in
            let newDate = self.date(byAdding: .day, value: day, to: fromDate)
            if let date = newDate {
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        
        return dates
    }
}

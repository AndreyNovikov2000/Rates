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

extension Calendar {
    
    struct PastTime {
        var numberOfComponents: Int
        var components: Component
        
        enum Component {
            case day
            case mouth
            case year
        }
    }
    
    
    func getPastTime(fromDate date: Date?) -> PastTime {
        guard let date = date else { return PastTime(numberOfComponents: 999, components: .day) }
        let currentDay = Date()
        let calendar = Calendar.current
        print(date)
        
        let currentYearComponents = calendar.component(.year, from: currentDay)
        let currentMounthComponents = calendar.component(.month, from: currentDay)
        let currentDayComponents = calendar.component(.day, from: currentDay)
        
        let yearComponents = calendar.component(.year, from: date)
        let monthComponents = calendar.component(.month, from: date)
        let dayComponents = calendar.component(.day, from: date)
        
        let yearDifference = abs(currentYearComponents - yearComponents)
        let monthDifference = abs(currentMounthComponents - monthComponents)
        let dayDifference = abs(currentDayComponents - dayComponents)
        
        if  yearDifference >= 1   {
            return PastTime(numberOfComponents: yearDifference, components: .year)
        }
        
        if dayDifference >= 1 && dayDifference <= 16 {
            return PastTime(numberOfComponents: dayDifference, components: .day)
        }
        
        if monthDifference >= 1 {
            return PastTime(numberOfComponents: monthDifference, components: .mouth)
        }
        
        return PastTime(numberOfComponents: 999, components: .day)
    }
}

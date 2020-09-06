//
//  DateFormatter + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

extension DateFormatter {
    func getDateString(fromDate date: Date, fromat: String = "YYYY-MM-dd") -> String {
        self.dateFormat = fromat
        return string(from: date)
    }
}

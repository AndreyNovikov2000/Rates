//
//  RateInterval.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/11/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

struct RateInterval {
    
    // MARK: - Propperties
    
    var daysInterval: [Int]
    var monthInterval: [Int]
    var yearInterval: [Int]
    
    var IsEmpty: Bool {
        return daysInterval.isEmpty && monthInterval.isEmpty && yearInterval.isEmpty
    }
 
    // MARK: - Init
    
    init() {
        self.init(daysInterval: [], monthInterval: [], yearInterval: [])
        setDefaulValue()
    }
    
    init(daysInterval: [Int], monthInterval: [Int], yearInterval: [Int]) {
        self.daysInterval = daysInterval
        self.monthInterval = monthInterval
        self.yearInterval = yearInterval
    }
    
    // MARK: - Methods
    
    mutating func setDefaulValue() {
        daysInterval = [-16]
        monthInterval = [-1, -2, -3, -5, -6]
        yearInterval = [-1]
    }
}

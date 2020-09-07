//
//  RateWrapped.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

struct RateWrapped {
    
    // MARK: - Properties
    
    var startDate: String
    var endDate: String
    var base: String
    var rates: [Rate]
    
    private let allRates = ["AED", "AFN", "ALL",
                                "ARS", "AUD", "BAM",
                                "BBD", "ZMW", "XPF",
                                "XOF", "XAF", "UZS"]
    
    // MARK: - Init
    
    init() {
        startDate = ""
        endDate = ""
        base = ""
        rates = []
    }
    
    init(startDate: String, endDate: String, base: String, rates: [Rate]) {
        self.startDate = startDate
        self.endDate = endDate
        self.base = base
        self.rates = rates
    }
    
    
    // MARK: - Public methods
    
    func getRateWrapped(fromDictionary dictionary: [String: Any], dateWrapped: DateWrapped) -> RateWrapped {
        let rates = dictionary["rates"] as? [String: Any]
        let ratesCount = rates?.keys.count ?? 0
        
        
        var ratesWrapped = RateWrapped(startDate: dateWrapped.startDate, endDate: dateWrapped.endDate, base: dateWrapped.baseRate, rates: [])
        
        allRates.forEach { (ratekey) in
            var rate = Rate(name: ratekey, rateValus: [])
            
            (0..<ratesCount - 1).forEach { (day) in
                guard let date = rates?[dateWrapped.dates[day]] as? [String: Any] else { return }
                guard let rateValue = date[ratekey] as? Double else { return }
                rate.rateValus.append(rateValue)
            }
            
            ratesWrapped.rates.append(rate)
        }
        
        return ratesWrapped
    }
}


extension RateWrapped: Hashable {
    
}

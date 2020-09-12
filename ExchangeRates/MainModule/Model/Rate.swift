//
//  Rate.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

struct Rate {
    
    // MARK: - Properties
    
    var name: String
    var rateValus: [Double]
    var fromDate: Date?
    
    var lastRateValue: String {
        return String(format: "%.2f", rateValus.last ?? 0)
    }
    
    
    var minRateValue: Double {
        return rateValus.min() ?? 0
    }
    
    var maxRateValue: Double {
        return rateValus.max() ?? 0
    }
    
    var med: Double {
        var value: Double = 0
        rateValus.forEach { (rate) in
            value += rate
        }
        value /= Double(rateValus.count)
        return value
    }
    
    enum RateValue {
        case maxRateValue
        case medinaMaxRateValue
        case medinaRateValue
        case medinaMinRateValue
        case minRateValue
    }
    
    // MARK: - Init
    
    init() {
        name = ""
        rateValus = []
    }
    
    init(name: String, rateValus: [Double]) {
        self.name = name
        self.rateValus = rateValus
    }

    // MARK: - Methods
    
    func getRate(withRateValue rateValue: RateValue) -> String {
        let maxRateValue = rateValus.max() ?? 0
        let minRateValue = rateValus.min() ?? 0
        let medinaRateValue = (maxRateValue + minRateValue) / 2
        let medinaMinRateValue = (minRateValue + medinaRateValue) / 2
        let medinaMaxRateValue =  (medinaRateValue + maxRateValue) / 2
        
        let stringFormat = "%.2f"
        
        switch  rateValue {
        case .maxRateValue:
            return String(format: stringFormat, maxRateValue)
        case .medinaMaxRateValue:
            return String(format: stringFormat, medinaMaxRateValue)
        case .medinaRateValue:
            return String(format: stringFormat, medinaRateValue)
        case .medinaMinRateValue:
            return String(format: stringFormat, medinaMinRateValue)
        case .minRateValue:
            return String(format: stringFormat, minRateValue)
        }
    }
}

extension Rate: Hashable {
}

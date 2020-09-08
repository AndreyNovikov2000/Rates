//
//  Rate.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

struct Rate {
    var name: String
    var rateValus: [Double]
    
    var lastRateValue: String {
        return String(format: "%.2f", rateValus.last ?? 0)
    }
}

extension Rate: Hashable {
    
}

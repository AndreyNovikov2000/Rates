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
}

extension Rate: Hashable {
    
}

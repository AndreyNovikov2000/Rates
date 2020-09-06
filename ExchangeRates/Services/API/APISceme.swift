//
//  APISceme.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

enum APISceme {
    case timeseries(fromDate: String, toDate: String, base: String)
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .timeseries(let fromDate, let toDate, base: let base):
            return [
                URLQueryItem(name: "start_date", value: fromDate),
                URLQueryItem(name: "end_date", value: toDate),
                URLQueryItem(name: "base", value: base)
            ]
        }
    }
    
    var path: String {
        switch self {
        case .timeseries:
            return "/timeseries"
        }
    }
}

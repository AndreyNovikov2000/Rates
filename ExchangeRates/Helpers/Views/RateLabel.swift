//
//  RateLabel.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/9/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class RateLabel: UILabel {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        text = "123"
        textColor = .white
        textAlignment = .center
        font = .boldSystemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  UIColor + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/12/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    
}

extension UIColor {
    static let backgroundBlack = UIColor(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
}

//
//  UIDatePicker + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

extension UIDatePicker {
    func setup() {
        self.maximumDate = Date()
        self.datePickerMode = .date
    }
}

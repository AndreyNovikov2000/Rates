//
//  UIViewController + extention.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/7/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, complition: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            complition?()
        }
        
        alert.addAction(okAction)
        show(alert, sender: nil)
    }
}

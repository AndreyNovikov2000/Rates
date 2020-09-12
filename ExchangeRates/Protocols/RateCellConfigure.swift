//
//  RateCellConfigure.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/12/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

protocol RateCellConfigure: UICollectionViewCell {
    static var reuseId: String { get }
    func configure<H>(withValue value: H) where H: Hashable
}

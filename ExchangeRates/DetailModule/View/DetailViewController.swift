//
//  DetailViewController.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/7/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getRate()
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func setRate(_ rate: Rate) {
        print(rate)
    }
}

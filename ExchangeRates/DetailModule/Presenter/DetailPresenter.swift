//
//  DetailPresenter.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/7/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func setRate(_ rate:  Rate)
}

protocol DetailPresenterProtocol  {
    init(view: DetailViewProtocol, rate: Rate, networkService: NetworkServiceProtocol)
    func getRate()
}

class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailViewProtocol!
    
    private(set) var rate: Rate
    var networkService: NetworkServiceProtocol
    
    // MARK: - Init
    
    required init(view: DetailViewProtocol,rate: Rate, networkService: NetworkServiceProtocol) {
        self.view = view
        self.rate = rate
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func getRate() {
        view.setRate(rate)
    }
}

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
    func setRates(_ rates: [Rate])
}

protocol DetailPresenterProtocol  {
    init(view: DetailViewProtocol, rates: [Rate], rate: Rate, networkService: NetworkServiceProtocol)
    func getRate()
    func getRates()
}

class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailViewProtocol!
    
    private(set) var rate: Rate
    private(set) var rates: [Rate]
    var networkService: NetworkServiceProtocol
    
    // MARK: - Init
    
    required init(view: DetailViewProtocol, rates: [Rate], rate: Rate, networkService: NetworkServiceProtocol) {
        self.view = view
        self.rate = rate
        self.networkService = networkService
        self.rates = rates
    }
    
    // MARK: - Methods
    
    func getRate() {
        view.setRate(rate)
    }
    
    func getRates() {
        view.setRates(rates)
    }
}

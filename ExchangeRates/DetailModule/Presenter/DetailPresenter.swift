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
    func setRequestsTimeInterval(_ rates: [Rate])
}

protocol DetailPresenterProtocol  {
    init(view: DetailViewProtocol, rates: [Rate], rate: Rate, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getRate()
    func getRates()
    func getRequestsTimeInterval(withRateInterval rateInterval: RateInterval)
    func didSelectRate(rates: [Rate], selectedRate: Rate)
}

class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailViewProtocol!
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol
    
    private(set) var rate: Rate
    private(set) var rates: [Rate]
    
    
    // MARK: - Init
    
    required init(view: DetailViewProtocol, rates: [Rate], rate: Rate, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
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
    
    func getRequestsTimeInterval(withRateInterval rateInterval: RateInterval) {
        var rates = [Rate]()
        
        rateInterval.daysInterval.forEach { (day) in
            var rate = Rate()
            rate.fromDate = Date().getDaysAgoFromCurretnDate(days: day)
            rates.append(rate)
        }
        
        rateInterval.monthInterval.forEach { (month) in
            var rate = Rate()
            rate.fromDate = Date().getTimeFromCurretnDate(withComponent: .month, componentValue: month)
            rates.append(rate)
        }
        
        rateInterval.yearInterval.forEach { (year) in
            var rate = Rate()
            rate.fromDate = Date().getTimeFromCurretnDate(withComponent: .year, componentValue: year)
            rates.append(rate)
        }
    
        view.setRequestsTimeInterval(rates)
    }
    
    func didSelectRate(rates: [Rate], selectedRate: Rate) {
        router?.showDetailViewController(withRates: rates, selectedRate: selectedRate)
    }
}


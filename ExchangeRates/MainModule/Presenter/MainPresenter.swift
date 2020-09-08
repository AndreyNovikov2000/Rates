//
//  MainPresenter.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func getTimeSeriesRates(withResult result: Result<RateWrapped, Error>)
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func loadTimeSeriesRates()
}

class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Properies
    
    weak var view: MainViewProtocol!
    let networkService: NetworkServiceProtocol
    
    private let dateFormatter = DateFormatter()
    private let calendar = Calendar.current
    
    // MARK: - Init
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func loadTimeSeriesRates() {
        let base = "USD"
        let toDate =  Date()
        let fromDate = Date().getDaysAgoFromCurretnDate(days: 30)
        
        let fromDateString = dateFormatter.getDateString(fromDate: fromDate)
        let toDateString = dateFormatter.getDateString(fromDate: toDate)
        let dates = calendar.getAllDates(fromDateString: fromDateString, toDateString: toDateString)
        let apiSceme: APISceme = .timeseries(fromDate: fromDateString, toDate: toDateString, base: base)
        
        networkService.getTimeSeriesRates(withRatePath: apiSceme) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dictionary):
                    guard let dictionary = dictionary else { return }
                    var rateWrapped = RateWrapped()
                    let dateWrapped = DateWrapped(startDate: fromDateString, endDate: toDateString, baseRate: base, dates: dates)
                    rateWrapped =  rateWrapped.getRateWrapped(fromDictionary: dictionary, dateWrapped: dateWrapped)
                    self.view.getTimeSeriesRates(withResult: .success(rateWrapped))
                    
                case .failure(let error):
                    self.view.getTimeSeriesRates(withResult: .failure(error))
                }
            }
        }
    }
}


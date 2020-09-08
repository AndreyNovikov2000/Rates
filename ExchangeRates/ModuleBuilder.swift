//
//  ModuleBuilder.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    static func buildMainModule() -> UIViewController
    static func buildDetailModule(rate: Rate) -> UIViewController
}

class Builder: BuilderProtocol {
    static func buildMainModule() -> UIViewController {
        let networkService = NetworkService()
        let mainViewController = MainViewController()
        let mainPresenter = MainPresenter(view: mainViewController, networkService: networkService)
        mainViewController.presenter = mainPresenter
        return mainViewController
    }
    
    static func buildDetailModule(rate: Rate) -> UIViewController {
        let networkService = NetworkService()
        let detailViewController = DetailViewController()
        let detailPresenter = DetailPresenter(view: detailViewController, rate: rate, networkService: networkService)
        detailViewController.presenter = detailPresenter
        return detailViewController
    }
}

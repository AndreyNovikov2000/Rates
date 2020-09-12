//
//  ModuleBuilder.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit


protocol AssembilityBuilderProtocol {
    func buildMainModule(_ router: RouterProtocol) -> UIViewController
    func buildDetailModule(withRouter router: RouterProtocol, rates: [Rate], selectedRate: Rate) -> UIViewController
}


class AssembilityBuilder: AssembilityBuilderProtocol {
    func buildMainModule(_ router: RouterProtocol) -> UIViewController {
        let mainViewController = MainViewController()
        let networkService = NetworkService()
        let mainPresenter = MainPresenter(view: mainViewController, networkService: networkService, router: router)
        mainViewController.presenter = mainPresenter
        return mainViewController
    }
    
    func buildDetailModule(withRouter router: RouterProtocol, rates: [Rate], selectedRate: Rate) -> UIViewController {
        let detailViewController = DetailViewController()
        let networkService = NetworkService()
        let detailPresenter = DetailPresenter(view: detailViewController, rates: rates, rate: selectedRate, networkService: networkService, router: router)
        detailViewController.presenter = detailPresenter
        return detailViewController
    }
}

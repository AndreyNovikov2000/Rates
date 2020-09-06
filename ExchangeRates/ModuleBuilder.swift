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
}

class Builder: BuilderProtocol {
    static func buildMainModule() -> UIViewController {
        let networkService = NetworkService()
        let mainViewController = MainViewController()
        let mainPresenter = MainPresenter(view: mainViewController, networkService: networkService)
        mainViewController.presenter = mainPresenter
        return mainViewController
    }
}

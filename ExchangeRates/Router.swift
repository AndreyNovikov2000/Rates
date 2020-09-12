//
//  Router.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/12/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit


protocol MainRouterProtocol {
    var navigationController:  UINavigationController? { get set }
    var assembilityBuilder: AssembilityBuilderProtocol? { get set }
}

protocol RouterProtocol: MainRouterProtocol {
    func initialViewController()
    func showDetailViewController(withRates rates: [Rate], selectedRate rate: Rate)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assembilityBuilder: AssembilityBuilderProtocol?
    
    init(navigationController: UINavigationController, assembilityBuilder: AssembilityBuilderProtocol) {
        self.navigationController = navigationController
        self.assembilityBuilder = assembilityBuilder
    }

    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let initinalViewController = assembilityBuilder?.buildMainModule(self) else { return }
            navigationController.viewControllers = [initinalViewController]
        }
    }
    
    func showDetailViewController(withRates rates: [Rate], selectedRate rate: Rate) {
        if let navigationController = navigationController {
            guard let detailViewController = assembilityBuilder?.buildDetailModule(withRouter: self, rates: rates, selectedRate: rate) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

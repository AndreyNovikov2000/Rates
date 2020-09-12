//
//  SceneDelegate.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let assembilityBulder = AssembilityBuilder()
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assembilityBuilder: assembilityBulder)
        router.initialViewController()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
    }
}


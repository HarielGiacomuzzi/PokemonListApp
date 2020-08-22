//
//  MainCoordinator.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol {
    func gotoRegisterScreen()
    func gotoHomeScreen()
    func completeSingupProcess()
}

extension MainCoordinatorProtocol {
    func gotoRegisterScreen() {}
    func gotoHomeScreen() {}
    func completeSingupProcess() {}
}

final class MainCoordinator: Coordinator {
    private var window: UIWindow
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController = {
       let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        nav.navigationBar.barTintColor = ColorPallet.lighGreen.color()
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

       return nav
   }()

    init(window: UIWindow) {
        self.window = window
    }


    func start() {
        let viewModel = InitialViewModel(coordinator: self)
        let initialView = InitialViewController(viewModel: viewModel)
        navigationController.pushViewController(initialView, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

//MARK: - MainCoordinatorProtocol
extension MainCoordinator: MainCoordinatorProtocol {
    func gotoRegisterScreen() {
        let registerCoordinator = SingupCoordinator(navigationController: navigationController, parentCoordinator: self)
        registerCoordinator.start()
    }

    func gotoHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }

    func completeSingupProcess() {
        navigationController.popToRootViewController(animated: false)
        gotoHomeScreen()
    }
}

//
//  HomeCoordinator.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 02/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    func start() {
        let viewModel = HomeViewModel()
        let initialView = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(initialView, animated: false)
    }
}

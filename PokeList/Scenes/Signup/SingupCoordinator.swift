//
//  SingupCoordinator.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 30/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol SingupCoordinatorProtocol {
    func proceedToStepTwo()
    func proceedToHome()
}

final class SingupCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var viewModel: SingupViewModelProtocol?
    var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController, parentCoordinator: Coordinator) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        var initialView: SingupNameRegister!
        if let viewModel = self.viewModel {
            initialView = SingupNameRegister(viewModel: viewModel)
        } else {
            let viewModel = SingupViewModel(coordinator: self)
            self.viewModel = viewModel
            initialView = SingupNameRegister(viewModel: viewModel)
        }

        navigationController.pushViewController(initialView, animated: false)
    }
}

extension SingupCoordinator: SingupCoordinatorProtocol {
    func proceedToStepTwo() {
        var stepTwoView: SingupPokemonType!
        if let viewModel = self.viewModel {
            stepTwoView = SingupPokemonType(viewModel: viewModel)
        } else {
            let viewModel = SingupViewModel(coordinator: self)
            self.viewModel = viewModel
            stepTwoView = SingupPokemonType(viewModel: viewModel)
        }

        navigationController.pushViewController(stepTwoView, animated: false)
    }

    func proceedToHome() {
        guard let mainCoordinator = parentCoordinator as? MainCoordinator else { return }
        mainCoordinator.completeSingupProcess()
    }
}

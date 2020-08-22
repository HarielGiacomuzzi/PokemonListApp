//
//  InitialViewModel.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 30/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol InitialViewModelProtocol {
    var coordinator: MainCoordinatorProtocol { get }

    func proceedToNextScreen()
}

final class InitialViewModel: InitialViewModelProtocol {
    var coordinator: MainCoordinatorProtocol

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func proceedToNextScreen() {
        if let _ = User.loadUser(), true {
            coordinator.gotoHomeScreen()
        } else {
            coordinator.gotoRegisterScreen()
        }
    }
}

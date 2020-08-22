//
//  CoordinatorProtocol.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get }
    var navigationController: UINavigationController { get set }

    func start()
}

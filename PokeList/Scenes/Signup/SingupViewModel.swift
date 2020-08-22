//
//  SingupViewModel.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 31/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol SingupViewModelProtocol {
    var name: String { get }
    var pokemonType: PokeType? { get set }
    var pokemonTypes: [PokeType] { get set }
    var user: User? { get set }
    var delegate: SingupViewModelDelegate? { get set }

    func proceedToStepTwo(with name: String)
    func proceedToHome()
}

protocol SingupViewModelDelegate {
    func didFetchPoketypes()
    func didUpdatePokeType()
}

extension SingupViewModelDelegate {
    func didUpdatePokeType() { }
    func didFetchPoketypes() { }
}

class SingupViewModel: SingupViewModelProtocol {
    var name: String = ""
    var user: User?
    var pokemonTypes: [PokeType] = []
    var coordinator: SingupCoordinatorProtocol!
    var delegate: SingupViewModelDelegate?
    var service: PokemonServiceProtocol = PokemonService()
    var pokemonType: PokeType? {
        didSet {
            delegate?.didUpdatePokeType()
        }
    }


    init(coordinator: SingupCoordinatorProtocol) {
        self.coordinator = coordinator

        fetchPokeTypes()
    }

    func fetchPokeTypes() {
        service.fetchPokemonTypes { (pokeTypes) in
            self.pokemonTypes = pokeTypes
            self.delegate?.didFetchPoketypes()
        }
    }

    func proceedToStepTwo(with name: String) {
        self.name = name
        coordinator.proceedToStepTwo()
    }

    func proceedToHome() {
        guard let prefferedPokemonType = pokemonType else { return }
        let user = User(userName: name, prefferedPokemon: prefferedPokemonType)
        user.saveUser()
        coordinator.proceedToHome()
    }
}

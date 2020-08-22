//
//  PokemonService.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonTypes(completion: @escaping ([PokeType]) -> Void)
    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void)
}

class PokemonService: PokemonServiceProtocol {
    private var pokeProvider: PokelistProviderProtocol!
    private var pokemonTypes: [PokeType] = []
    private var pokemonList: [Pokemon] = []

    init(serviceType: ServiceType = .QA) {
        self.pokeProvider = PokemomListProvider(backendService: serviceType)
    }


    func fetchPokemonTypes(completion: @escaping ([PokeType]) -> Void) {
        pokeProvider.getPokemonTypes { result in
            switch result {
                case .failure(let error):
                    debugPrint("Could not fetch pokemonTypes. Details: \(error.localizedDescription)")
                case .success(let pokeTypes):
                    self.pokemonTypes = pokeTypes
                    completion(pokeTypes)
            }
        }
    }

    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void) {
        pokeProvider.getPokemons { result in
            switch result {
                case .failure(let error):
                    debugPrint("Could not fetch pokemonTypes. Details: \(error.localizedDescription)")
                case .success(let pokemons):
                    self.pokemonList = pokemons
                    completion(pokemons)
            }
        }
    }
}

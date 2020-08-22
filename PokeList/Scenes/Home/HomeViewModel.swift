//
//  HomeViewModel.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 01/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    var pokemonType: PokeType? { get }
    var pokemonTypes: [PokeType] { get }
    var pokemons: [Pokemon] { get }
    var delegate: HomeViewModelDelegate? { get set }

    func fetchData()
    func filterByType(type: PokeType)
    func sortByName(direction: Direction)
    func searchByName(searchString: String)
}

protocol HomeViewModelDelegate {
    func didFetchPoketypes()
    func didFetchPokemons()
}

class HomeViewModel: HomeViewModelProtocol {
    var pokemonType: PokeType?
    var pokemonTypes: [PokeType] = []
    var pokemons: [Pokemon] = []
    var pokemonsData: [Pokemon] = []
    var delegate: HomeViewModelDelegate?
    var service: PokemonServiceProtocol = PokemonService()

    func fetchData() {
        fetchPokeTypes()
        fetchPokemons()
    }

    func fetchPokeTypes() {
        service.fetchPokemonTypes { (pokeTypes) in
            self.pokemonTypes = pokeTypes
            self.delegate?.didFetchPoketypes()
        }
    }

    func fetchPokemons() {
        service.fetchPokemons { (pokemons) in
            self.pokemonsData = pokemons
            self.pokemons = pokemons
            self.sortByName(direction: .asc)
            self.delegate?.didFetchPokemons()
        }
    }

    func filterByType(type: PokeType) {
        self.pokemons = pokemonsData.filter { $0.type.contains(type.name) }
        delegate?.didFetchPokemons()
    }

    func sortByName(direction: Direction) {
        if direction == .asc {
            pokemons = pokemons.sorted(by: { $0.name > $1.name })
        } else {
            pokemons = pokemons.sorted(by: { $0.name < $1.name })
        }
        delegate?.didFetchPokemons()
    }

    func searchByName(searchString: String) {
        pokemons = pokemonsData.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        delegate?.didFetchPokemons()
    }
}

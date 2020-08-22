//
//  PokeProvider.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol PokelistProviderProtocol {
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
    func getPokemonTypes(completion: @escaping (Result<[PokeType], Error>) -> Void)
}

final class PokemomListProvider: BaseProvider, PokelistProviderProtocol {
    private var basePath: String

    init(backendService: ServiceType = .QA) {
        basePath = Environment.PokemomListBasePath
    }


    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        callAPI(queryString: nil, urlPath: "\(basePath)/pokemons.json") { response in
            switch response {
            case .failure(let error):
                debugPrint("Could not fetch pokemons. Details: \(error.localizedDescription)")
                completion(.failure(error))
            case .success(let pokeData):
                do {
                    let pokemons = try JSONDecoder().decode([Pokemon].self, from: pokeData)
                    completion(.success(pokemons))
                } catch let error {
                    debugPrint("Could not decode pokemons. Details: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }

    func getPokemonTypes(completion: @escaping (Result<[PokeType], Error>) -> Void) {
        callAPI(queryString: nil, urlPath: "\(basePath)/types.json") { response in
                switch response {
                case .failure(let error):
                    debugPrint("Could not fetch pokemom types. Details: \(error.localizedDescription)")
                    completion(.failure(error))
                case .success(let pokeData):
                    do {
                        let types = try JSONDecoder().decode(PokeTypeResponse.self, from: pokeData)
                        completion(.success(types.results))
                    } catch let error {
                        debugPrint("Could not decode pokemon types. Details: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
        }
    }
}

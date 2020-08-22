//
//  PokemonType.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

struct PokeTypeResponse: Decodable {
    let results: [PokeType]
}

struct PokeType: Codable {
    let thumbnailImage: String
    let name: String
}

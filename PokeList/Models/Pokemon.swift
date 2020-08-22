//
//  Pokemon.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [String]
    let detailPageURL: String
    let weight: Double
    let weakness: [String]
    let number: String
    let height: Int
    let collectiblesSlug, featured, slug, name: String
    let thumbnailAltText: String
    let thumbnailImage: String
    let id: Int
    let type: [String]

    enum CodingKeys: String, CodingKey {
        case abilities, detailPageURL, weight, weakness, number, height
        case collectiblesSlug = "collectibles_slug"
        case featured, slug, name, thumbnailAltText, thumbnailImage, id, type
    }
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

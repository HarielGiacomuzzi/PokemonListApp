//
//  Constants.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

struct KeyNames {
    static let PokemomListBasePath = "POKEMOM_LIST_BASE_PATH"
    static let PokemomAssetsBasePath = "POKEMOM_ASSETS_BASE_PATH"
}

struct CI {
    static var PokemomListBasePath: String = "$(\(KeyNames.PokemomListBasePath))"
    static var PokemomImageBasePath: String = "$(\(KeyNames.PokemomAssetsBasePath))"
}

enum ServiceType {
    case Production
    case QA
}

struct Environment {
    //MARK: Commom Values
    static var PokemomListBasePath: String = Environment.variable(named: KeyNames.PokemomListBasePath) ?? CI.PokemomListBasePath
    static var PokemomImageBasePath: String = Environment.variable(named: KeyNames.PokemomAssetsBasePath) ?? CI.PokemomImageBasePath

    static func variable(named name: String) -> String? {
        let processInfo = ProcessInfo.processInfo
        guard let value = processInfo.environment[name] else {
            return nil
        }
        return value
    }
}

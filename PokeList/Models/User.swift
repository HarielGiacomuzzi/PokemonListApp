//
//  User.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

class User: Codable {
    var userName: String
    var prefferedPokemon: PokeType

    init(userName: String, prefferedPokemon: PokeType) {
        self.userName = userName
        self.prefferedPokemon = prefferedPokemon
    }

    func saveUser() {
        let userData = try? JSONEncoder().encode(self)

        UserDefaultsWrapper().userData = userData
    }

    static func loadUser() -> User? {
        guard let userData = UserDefaultsWrapper().userData,
              let user = try? JSONDecoder().decode(User.self, from: userData) else { return nil }

        return user
    }
}

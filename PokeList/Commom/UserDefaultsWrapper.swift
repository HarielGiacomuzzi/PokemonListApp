//
//  UserDefaultsWrapper.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 31/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol UserDefaultsWrapperProtocol: AnyObject {
    var userData: Data? { get set }
}

enum UserDefaultsEnum: String {
    case userData
}

final class UserDefaultsWrapper: UserDefaultsWrapperProtocol {
    var userData: Data? {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsEnum.userData.rawValue) as? Data
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsEnum.userData.rawValue)
        }
    }
}

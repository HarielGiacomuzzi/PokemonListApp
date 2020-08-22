//
//  Array+Unique.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 02/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var uniques: Array {
        return Array(Set(self))
    }
}

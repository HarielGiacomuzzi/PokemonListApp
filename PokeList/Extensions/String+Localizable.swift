//
//  String+Localizable.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 30/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

extension String {
    static func localized(by key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    static func localizedComplement(by key: String, with complement: CVarArg...) -> String {
        return String(format: NSLocalizedString(key, comment: "%@"), arguments: complement)
    }
}

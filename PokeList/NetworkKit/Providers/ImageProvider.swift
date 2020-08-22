//
//  ImageProvider.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol ImageProvider: class {
    func getImage(url: String, backendService: ServiceType, completion: @escaping (Data?) -> Void)
}

final class PokemomImageProvider: BaseProvider, ImageProvider {

    override init() {
        super.init()
    }

    func getImage(url: String, backendService: ServiceType = .QA, completion: @escaping (Data?) -> Void) {
        callAPI(queryString: nil, urlPath: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                debugPrint("Error while getting image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}

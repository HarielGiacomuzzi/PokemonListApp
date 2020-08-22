//
//  ImageCache.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class ImageCache {
    static let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    static let imageProvider = PokemomImageProvider()

    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


    static func downloadImage(url: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            imageProvider.getImage(url: url, backendService: .QA) { data in
               guard let data = data else { return }
               DispatchQueue.main.async() {
                    guard let image = UIImage(data: data) else { return }
                    cache.setObject(image, forKey: url as NSString)
                    completion(image)
               }
           }
        }
    }
}

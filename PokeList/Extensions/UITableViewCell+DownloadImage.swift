//
//  UITableViewCell+DownloadImage.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 02/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func setImage(for string: String) {
        ImageCache.downloadImage(url: string) { (image) in
            self.imageView?.contentMode = .scaleAspectFit
            self.imageView?.image = image
            self.layoutSubviews()
        }
    }
}

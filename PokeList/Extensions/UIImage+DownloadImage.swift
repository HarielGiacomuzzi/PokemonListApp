//
//  UIImage+DownloadImage.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        ImageCache.downloadImage(url: url) { image in
            self.image = image
        }
    }
}

extension UIImageView {
    func addRoundedBorder(radious: CGFloat, color: CGColor, borderWidth: CGFloat = 1.0) {
        self.layer.cornerRadius = radious
        self.layer.borderColor = color
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}


extension UIImage {
    func rotated(byDegrees degree: Double) -> UIImage {
        let radians = CGFloat(degree * .pi) / 180.0 as CGFloat
        let rotatedSize = self.size
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, scale)
        let bitmap = UIGraphicsGetCurrentContext()
        bitmap?.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        bitmap?.rotate(by: radians)
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(
            self.cgImage!,
            in: CGRect.init(x: -self.size.width / 2, y: -self.size.height / 2 , width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

}

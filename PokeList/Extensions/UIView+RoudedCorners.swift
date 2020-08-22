//
//  UIView+RoudedCorners.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

extension UIView {
    func makeRoundedCorners(radious: CGFloat) {
        self.layer.cornerRadius = radious
        self.layer.masksToBounds = true
    }

    func setGradientBackground(topColor: CGColor, bottomColor: CGColor) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
}

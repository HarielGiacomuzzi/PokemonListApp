//
//  PokeTextField.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 30/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

public class PokeTextField: UITextField {

    // MARK: - Constants
    private struct Constants {
        static let BottomLayerName = "TextFieldBottom"
        static let BottomLayerTextName = "TextFieldBottomText"
    }

    // MARK: - Variables
    public var invalidMessage: String?
    private var bottomBorderColor: CGColor = UIColor.white.cgColor
    private var enableLongPress: Bool = true
    public var isFieldValid: Bool = true {
        didSet {
            if isFieldValid {
                bottomBorderColor = UIColor.white.cgColor
            } else {
                bottomBorderColor = UIColor.red.cgColor
            }
        }
    }

    /// A simple textField with placeholder text and bottom border
    /// - Parameters:
    ///   - placeholderText: The string to be displayed as placeholder.
    ///   - textColor: The color of the text, defaults to black
    ///   - textFont: The font of the textField, defaults to System of size 16.0
    public init(placeholderText: String? = nil,
                textColor: UIColor = .black,
                textFont: UIFont = .systemFont(ofSize: 16.0),
                enableLongPress: Bool = true) {
        super.init(frame: .zero)

        self.enableLongPress = enableLongPress
        self.placeholder = placeholderText
        self.textColor = textColor
        self.font = textFont
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        setupBottomBorder()
    }

    private func removeLayers() {
        if let bottom = layer.sublayers?.filter({ $0.name == Constants.BottomLayerName }),
           !bottom.isEmpty {
            bottom.first?.removeFromSuperlayer()
        }

        if let bottom = layer.sublayers?.filter({ $0.name == Constants.BottomLayerTextName }),
           !bottom.isEmpty {
            bottom.first?.removeFromSuperlayer()
        }
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableLongPress
    }

    private func setupBottomBorder() {
        removeLayers()

        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: bounds.maxY, width: bounds.width, height: 1.0)
        bottomLine.backgroundColor = bottomBorderColor
        layer.addSublayer(bottomLine)

        if let text = invalidMessage, !isFieldValid {
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: 0.0, y: bounds.maxY + 6.0, width: bounds.width, height: 18.0)
            textLayer.alignmentMode = .center
            textLayer.string = text
            textLayer.font = UIFont.systemFont(ofSize: 14.0)
            textLayer.fontSize = 14.0
            textLayer.truncationMode = .end
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.isWrapped = true
            textLayer.foregroundColor = bottomBorderColor
            textLayer.name = Constants.BottomLayerTextName
            textLayer.contentsScale = UIScreen.main.scale

            layer.addSublayer(textLayer)
        }
    }
}

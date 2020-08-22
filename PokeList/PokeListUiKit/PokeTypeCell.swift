//
//  PokeTypeCell.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 01/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class PokeTypeCell: UITableViewCell {
    // MARK: - Views
    private lazy var checkBox: UIImageView = {
        let checkbox = UIImageView(frame: .zero)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.image = #imageLiteral(resourceName: "radio-off")
        checkbox.contentMode = .scaleAspectFit

        return checkbox
    }()

    // MARK: - Lifecycle
    init() {
        super.init(style: .default, reuseIdentifier: nil)

        self.separatorInset = .zero
        setupCheckBox()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func clearCheckbox() {
        checkBox.image = #imageLiteral(resourceName: "radio-off")
        layoutSubviews()
    }

    func markCheckbox() {
        checkBox.image = #imageLiteral(resourceName: "radio-on")
        layoutSubviews()
    }
}

// MARK: - View Configuration
extension PokeTypeCell {
    func setupViews() {
        setupCheckBox()
    }

    private func setupCheckBox() {
        contentView.addSubview(checkBox)

        NSLayoutConstraint.activate([
            checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            checkBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            checkBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            checkBox.widthAnchor.constraint(equalToConstant: 44.0)
        ])
    }
}

//
//  PokeFilterOption.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 02/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol PokeFilterOptionDelegate {
    func didSelectItem(filterItem: PokeType?)
}

class PokeFilterOption: UIView {
    // MARK: - Views
    var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapOption), for: .touchUpInside)

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0

        return stack
    }()

    private lazy var optionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.textAlignment = .center

        return label
    }()

    // MARK: - Variables
    private var option: PokeType?
    var delegate: PokeFilterOptionDelegate?

    // MARK: - Lifecycle
    init(option: PokeType, downloadImage: String? = nil) {
        super.init(frame: .zero)

        self.option = option
        if let imageURL = downloadImage {
            ImageCache.downloadImage(url: imageURL) { (image) in
                self.actionButton.imageView?.contentMode = .scaleAspectFit
                self.actionButton.setImage(image, for: .normal)
                self.actionButton.layoutSubviews()
            }
        }

        self.optionLabel.text = option.name.capitalized

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    @objc private func didTapOption() {
        delegate?.didSelectItem(filterItem: option)
    }
}

// MARK: - ViewConfiguration
extension PokeFilterOption {
    private func setupView() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 85.0),
            self.widthAnchor.constraint(equalToConstant: 80.0)
        ])

        setupStackView()
        setupActionButton()
        setupOptionLabel()
    }

    private func setupStackView() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupActionButton() {
        stackView.addArrangedSubview(actionButton)

        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 60.0),
            actionButton.widthAnchor.constraint(equalToConstant: 60.0)
        ])
    }

    private func setupOptionLabel() {
        stackView.addArrangedSubview(optionLabel)

        NSLayoutConstraint.activate([
            optionLabel.heightAnchor.constraint(equalToConstant: 20.0),
            optionLabel.widthAnchor.constraint(equalToConstant: 80.0)
        ])
    }
}

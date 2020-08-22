//
//  PokemonListHeader.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 03/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

enum Direction {
    case asc
    case desc
}

protocol PokemonListHeaderDelegate {
    func didTapSortingByName(direction: Direction)
}

class PokemonListHeader: UIView {
    // MARK: - Views
    private lazy var pokemonLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = String.localized(by: "pokemon")

        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = String.localized(by: "name")

        return label
    }()

    private var sortingButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapSorting), for: .touchUpInside)

        return button
    }()

    // MARK: - Variables
    private var sortingDirection = Direction.asc
    var delegate: PokemonListHeaderDelegate?

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    @objc private func didTapSorting() {
        sortingDirection = sortingDirection == Direction.asc ? .desc : .asc

        if sortingDirection == .desc {
            let image = #imageLiteral(resourceName: "arrow").rotated(byDegrees: 180.0)
            sortingButton.setImage(image, for: .normal)
        } else {
            sortingButton.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        }

        delegate?.didTapSortingByName(direction: sortingDirection)
    }
}

// MARK: - ViewConfiguration
extension PokemonListHeader {
    private func setupViews() {
        setupPokemonLabel()
        setupSortingButton()
        setupNameLabel()
    }

    private func setupSortingButton() {
        addSubview(sortingButton)

        NSLayoutConstraint.activate([
            sortingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            sortingButton.widthAnchor.constraint(equalToConstant: 50.0),
            sortingButton.heightAnchor.constraint(equalToConstant: 50.0),
            sortingButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupNameLabel() {
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: sortingButton.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupPokemonLabel() {
        addSubview(pokemonLabel)

        NSLayoutConstraint.activate([
            pokemonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25.0),
            pokemonLabel.topAnchor.constraint(equalTo: topAnchor),
            pokemonLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  PokeListHeader.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 02/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol PokeListHeaderFilerDelegate {
    func didSelectFilter(filter: PokeType?)
}

class PokeListHeaderFilterView: UIView {
    // MARK: - Views
    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 5.0

        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.contentMode = .center

        return scrollView
    }()

    // MARK: - Variables
    var delegate: PokeListHeaderFilerDelegate?

    // MARK: - Lifecycle
    init(filterOptions: [PokeType] = []) {
        super.init(frame: .zero)
        setupViews()
        addFilterOptions(options: filterOptions)
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func updateFilterOptions(filter: [PokeType]) {
        addFilterOptions(options: filter)
    }

    private func addFilterOptions(options: [PokeType]) {
        _ = stackView.subviews.map { $0.removeFromSuperview() }
        var stackWidth: CGFloat = 0.0
        for option in options {
            let optionItem = PokeFilterOption(option: option, downloadImage: option.thumbnailImage)
            optionItem.delegate = self
            stackView.addArrangedSubview(optionItem)
            stackWidth += 85.0
        }

        scrollView.contentSize = CGSize(width: stackWidth, height: CGFloat(self.bounds.height))
        self.layoutSubviews()
    }
}

// MARK: - FilterOptionDelegate
extension PokeListHeaderFilterView: PokeFilterOptionDelegate {
    func didSelectItem(filterItem: PokeType?) {
        delegate?.didSelectFilter(filter: filterItem)
    }
}

// MARK: - ViewConfiguration
extension PokeListHeaderFilterView {
    private func setupViews() {
        setupScrollView()
        setupStackView()
    }

    private func setupScrollView() {
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupStackView() {
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

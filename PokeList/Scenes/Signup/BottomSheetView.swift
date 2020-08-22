//
//  BottomSheetView.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 31/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

protocol BottomSheedViewDelegate {
    func didFinishSelection(pokeType: PokeType?)
}

class BottomSheetView: UIViewController {
    // MARK: - ViewComponents
    private lazy var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()

    private lazy var pokeTypesTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self

        return table
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String.localized(by: "confirm"), for: .normal)
        button.makeRoundedCorners(radious: 18.0)
        button.backgroundColor = ColorPallet.pink.color()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)

        return button
    }()

    // MARK: - Variables
    private var viewModel: SingupViewModelProtocol?
    var delegate: BottomSheedViewDelegate?

    // MARK: - LifeCycle
    init(viewModel: SingupViewModelProtocol?) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.viewModel?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupView()
    }

    // MARK: - Functions
    @objc private func didTapContinue() {
        delegate?.didFinishSelection(pokeType: viewModel?.pokemonType)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableViewDatasource
extension BottomSheetView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pokemonTypes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PokeTypeCell()
        cell.selectionStyle = .none

        if let pokeType = viewModel?.pokemonTypes[indexPath.row] {
            if let selectedType = viewModel?.pokemonType,
               selectedType.name == pokeType.name {
                cell.markCheckbox()
            }
            cell.textLabel?.text = pokeType.name.capitalized
            cell.setImage(for: pokeType.thumbnailImage)
        }

        return cell
    }
}

// MARK: - TableViewDelegate
extension BottomSheetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedType = viewModel?.pokemonTypes[indexPath.row] else { return }

        viewModel?.pokemonType = selectedType

        tableView.reloadData()
    }
}

// MARK: - SingupViewModelDelegate
extension BottomSheetView: SingupViewModelDelegate {
    func didFetchPoketypes() {
        pokeTypesTable.reloadData()
    }
}

// MARK: - ViewConfiguration Functions
extension BottomSheetView {
    private func setupView() {
        configureContainerView()
        configureContinueButton()
        configurePokeTypesTable()
    }

    private func configurePokeTypesTable() {
        view.addSubview(pokeTypesTable)

        NSLayoutConstraint.activate([
            pokeTypesTable.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            pokeTypesTable.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            pokeTypesTable.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -8.0),
            pokeTypesTable.topAnchor.constraint(equalTo: viewContainer.topAnchor)
        ])
    }

    private func configureContinueButton() {
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46.0),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46.0),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24.0),
            continueButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }

    private func configureContainerView() {
        view.addSubview(viewContainer)

        NSLayoutConstraint.activate([
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewContainer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7)
        ])
    }
}

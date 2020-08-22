//
//  HomeViewController.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 01/06/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Views
    private lazy var pokemonList: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private lazy var pokemonTypeFilter: PokeListHeaderFilterView = {
        let view = PokeListHeaderFilterView(filterOptions: self.viewModel?.pokemonTypes ?? [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self

        return view
    }()

    // MARK: - Variables
    private var viewModel: HomeViewModelProtocol?
    private var listHeader = PokemonListHeader()
    private var searchController = UISearchController(searchResultsController: nil)

    // MARK: - LifeCycle
    init(viewModel: HomeViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
        self.viewModel?.delegate = self
        listHeader.delegate = self
        self.viewModel?.fetchData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = String.localized(by: "homeTitle")
        view.backgroundColor = ColorPallet.lighGreen.color()
        setupView()
        setupSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Functions
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchController))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

    @objc private func showSearchController() {
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - TableViewDatasource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pokemons.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return listHeader
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.selectionStyle = .none
        cell.separatorInset = .zero
        if let pokemon = viewModel?.pokemons[indexPath.row] {
            cell.textLabel?.text = pokemon.name
            cell.setImage(for: pokemon.thumbnailImage)
        }

        return cell
    }
}

// MARK: - TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

// MARK: SearchControllerDelegate
extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    if let searchText = searchBar.text, !searchText.isEmpty {
        viewModel?.searchByName(searchString: searchText)
    }
  }
}

// MARK: PokeListHeaderViewDelegate
extension HomeViewController: PokeListHeaderFilerDelegate {
    func didSelectFilter(filter: PokeType?) {
        guard let filterOption = filter else { return }
        viewModel?.filterByType(type: filterOption)
    }
}

// MARK: PokemonHeaderViewDelegate
extension HomeViewController: PokemonListHeaderDelegate {
    func didTapSortingByName(direction: Direction) {
        viewModel?.sortByName(direction: direction)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate{
    func didFetchPoketypes() {
        DispatchQueue.main.async {
            self.pokemonTypeFilter.updateFilterOptions(filter: self.viewModel?.pokemonTypes ?? [])
            self.pokemonTypeFilter.layoutSubviews()
        }
    }

    func didFetchPokemons() {
        DispatchQueue.main.async {
            self.pokemonList.reloadData()
        }
    }
}

// MARK: - ViewConfiguration
extension HomeViewController {
    private func setupView() {
        setupPokeTypeFilter()
        setupPokemonTable()
    }

    private func setupPokeTypeFilter() {
        view.addSubview(pokemonTypeFilter)

        NSLayoutConstraint.activate([
            pokemonTypeFilter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTypeFilter.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTypeFilter.heightAnchor.constraint(equalToConstant: 90.0),
            pokemonTypeFilter.topAnchor.constraint(equalTo: view.topAnchor, constant: 90.0)
        ])
    }

    private func setupPokemonTable() {
        view.addSubview(pokemonList)

        NSLayoutConstraint.activate([
            pokemonList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pokemonList.topAnchor.constraint(equalTo: pokemonTypeFilter.bottomAnchor)
        ])
    }
}

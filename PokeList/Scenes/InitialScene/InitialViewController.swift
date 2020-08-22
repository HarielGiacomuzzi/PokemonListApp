//
//  ViewController.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 29/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController {
    // MARK: - ViewComponents
    private lazy var backgroungImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "bg")

        return imageView
    }()

    private lazy var pokemonLogoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "pokemon-logo")

        return imageView
    }()

    private lazy var finderLogoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "finder")

        return imageView
    }()

    private lazy var pikachuImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "pikachu")

        return imageView
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String.localized(by: "letsgo"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22.0, weight: .semibold)
        button.backgroundColor = ColorPallet.pink.color()
        button.makeRoundedCorners(radious: 18.0)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)

        return button
    }()

    //MARK: - Variables
    let viewModel: InitialViewModelProtocol?

    // MARK: - ViewLifecycle
    init(viewModel: InitialViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewWillAppear(_ animated: Bool) {
        setupViews()

        super.viewWillAppear(animated)
    }

    // MARK: - Functions
    @objc private func didTapContinue() {
        viewModel?.proceedToNextScreen()
    }
}

// MARK: - ViewConfiguration Functions
extension InitialViewController {
    func setupViews() {
        setupBackgroundView()
        setupPokemonLogoView()
        setupFinderImageView()
        setupPikachuImageView()
        setupContinueButtom()
    }

    func setupBackgroundView() {
        view.addSubview(backgroungImage)

        NSLayoutConstraint.activate([
            backgroungImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupPokemonLogoView() {
        view.addSubview(pokemonLogoImage)

        NSLayoutConstraint.activate([
            pokemonLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.0),
            pokemonLogoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.0),
            pokemonLogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60.0),
            pokemonLogoImage.heightAnchor.constraint(equalToConstant: 140.0)
        ])
    }

    func setupFinderImageView() {
        view.addSubview(finderLogoImage)

        NSLayoutConstraint.activate([
            finderLogoImage.centerXAnchor.constraint(equalTo: pokemonLogoImage.centerXAnchor),
            finderLogoImage.leadingAnchor.constraint(equalTo: pokemonLogoImage.leadingAnchor),
            finderLogoImage.trailingAnchor.constraint(equalTo: pokemonLogoImage.trailingAnchor),
            finderLogoImage.topAnchor.constraint(equalTo: pokemonLogoImage.bottomAnchor, constant: -8.0),
            finderLogoImage.heightAnchor.constraint(equalToConstant: 45.0)
        ])
    }

    func setupPikachuImageView() {
        view.addSubview(pikachuImageView)

        NSLayoutConstraint.activate([
            pikachuImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5.0),
            pikachuImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pikachuImageView.widthAnchor.constraint(equalToConstant: 240.0),
            pikachuImageView.heightAnchor.constraint(equalToConstant: 240.0)
        ])
    }

    func setupContinueButtom() {
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.0),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.0),
            continueButton.heightAnchor.constraint(equalToConstant: 60.0),
            continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


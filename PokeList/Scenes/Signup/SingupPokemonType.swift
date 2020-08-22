//
//  SingupPokemonType.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 31/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class SingupPokemonType: UIViewController {
    // MARK: - ViewComponents
    private lazy var backgroungImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "bg")

        return imageView
    }()

    private lazy var instructionText: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 26.0, weight: .medium)
        label.text = String.localizedComplement(by: "welcomeUser", with: viewModel?.name ?? "")
        label.textAlignment = .center

        return label
    }()

    private lazy var instructionTwo: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 21.0, weight: .regular)
        label.numberOfLines = 2
        label.text = String.localized(by: "welcomeInstruction")
        label.textAlignment = .left

        return label
    }()

    private lazy var textInput: PokeTextField = {
        let input = PokeTextField(placeholderText: "", textColor: .white, enableLongPress: false)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.delegate = self

        return input
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)

        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        return button
    }()

    // MARK: - Variables
    var viewModel: SingupViewModelProtocol?

    // MARK: - ViewLifecycle
    init(viewModel: SingupViewModelProtocol){
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupViews()

        super.viewWillAppear(animated)
    }

    // MARK: - Functions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapContinue() {
        if let prefferedType = textInput.text,
            !prefferedType.isEmpty {
            viewModel?.proceedToHome()
        }
    }
}

// MARK: - TextFieldDelegate
extension SingupPokemonType: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textInput.endEditing(true)

        modalPresentationStyle = .overCurrentContext
        let bottomSheetView = BottomSheetView(viewModel: self.viewModel)
        bottomSheetView.delegate = self
        present(bottomSheetView, animated: true) {
            self.textInput.text = self.viewModel?.pokemonType?.name.capitalized ?? ""
            self.view.layoutSubviews()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// MARK: - BottomSheetDelegate
extension SingupPokemonType: BottomSheedViewDelegate {
    func didFinishSelection(pokeType: PokeType?) {
        self.textInput.text = pokeType?.name.capitalized ?? ""
        self.view.layoutSubviews()
    }
}

// MARK: - SingupViewModelDelegate
extension SingupPokemonType: SingupViewModelDelegate {
    func didUpdatePokeType() {
        textInput.text = viewModel?.pokemonType?.name.capitalized ?? ""
    }
}

// MARK: - ViewConfiguration Functions
extension SingupPokemonType {
    private func setupViews() {
        setupBackgroundView()
        setupContinueButton()
        setupInstructionLabel()
        setupInstructionTwoLabel()
        setupNameTextField()
        configureBackButton()
    }

    private func configureBackButton() {
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 50.0),
            backButton.heightAnchor.constraint(equalToConstant: 50.0),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0)
        ])
    }

    private func setupBackgroundView() {
        view.addSubview(backgroungImage)

        NSLayoutConstraint.activate([
            backgroungImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupContinueButton() {
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            continueButton.heightAnchor.constraint(equalToConstant: 60.0),
            continueButton.widthAnchor.constraint(equalToConstant: 60.0),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupInstructionLabel() {
        view.addSubview(instructionText)

        NSLayoutConstraint.activate([
            instructionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            instructionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            instructionText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80.0),
            instructionText.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }

    private func setupNameTextField() {
        view.addSubview(textInput)

        NSLayoutConstraint.activate([
            textInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            textInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            textInput.heightAnchor.constraint(equalToConstant: 60.0),
            textInput.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 110.0)
        ])
    }

    private func setupInstructionTwoLabel() {
        view.addSubview(instructionTwo)

        NSLayoutConstraint.activate([
            instructionTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            instructionTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20.0),
            instructionTwo.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 50.0),
            instructionText.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
}

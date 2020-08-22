//
//  SignupNameRegister.swift
//  PokeList
//
//  Created by Hariel Giacomuzzi on 30/05/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

final class SingupNameRegister: UIViewController {
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
        label.text = String.localized(by: "nameInstruction")
        label.textAlignment = .center

        return label
    }()

    private lazy var instructionTwo: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 21.0, weight: .regular)
        label.numberOfLines = 2
        label.text = String.localized(by: "nameInstructionTwo")
        label.textAlignment = .left

        return label
    }()

    private lazy var textInput: PokeTextField = {
        let input = PokeTextField(placeholderText: "", textColor: .white)
        input.translatesAutoresizingMaskIntoConstraints = false

        return input
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        button.addTarget(self, action: #selector(proceedToStepTwo), for: .touchUpInside)

        return button
    }()

    // MARK: - Variables
    var viewModel: SingupViewModelProtocol?

    // MARK: - ViewLifecycle
    init(viewModel: SingupViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
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
    @objc private func proceedToStepTwo() {
        if let text = textInput.text,
           !text.isEmpty {
            viewModel?.proceedToStepTwo(with: text)
        }
    }
}

// MARK: - ViewConfiguration Functions
extension SingupNameRegister {
    func setupViews() {
        setupBackgroundView()
        setupContinueButton()
        setupInstructionLabel()
        setupInstructionTwoLabel()
        setupNameTextField()
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

    func setupContinueButton() {
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            continueButton.heightAnchor.constraint(equalToConstant: 60.0),
            continueButton.widthAnchor.constraint(equalToConstant: 60.0),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupInstructionLabel() {
        view.addSubview(instructionText)

        NSLayoutConstraint.activate([
            instructionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            instructionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            instructionText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80.0),
            instructionText.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }

    func setupNameTextField() {
        view.addSubview(textInput)

        NSLayoutConstraint.activate([
            textInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            textInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            textInput.heightAnchor.constraint(equalToConstant: 60.0),
            textInput.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 110.0)
        ])
    }

    func setupInstructionTwoLabel() {
        view.addSubview(instructionTwo)

        NSLayoutConstraint.activate([
            instructionTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            instructionTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20.0),
            instructionTwo.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 50.0),
            instructionText.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
}

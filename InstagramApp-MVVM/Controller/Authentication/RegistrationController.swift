//
//  RegistrationController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 16/03/2021.
//

import UIKit

class RegistrationController: UIViewController {

    //MARK: - Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname", isSecureTextEntry: false)
    
    private let usernameTextField = CustomTextField(placeholder: "Username", isSecureTextEntry: false)

    private let emailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email", isSecureTextEntry: false)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureTextEntry: true)

    private let signUpButton: AuthButton = {
        let button = AuthButton(title: "Sign Up")
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Already have an account?  ", secondPart: "Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Functions
    
    private func configureUI() {
        view.addGradientWithColors(.systemPurple, .systemBlue, direction: .topToBottom)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

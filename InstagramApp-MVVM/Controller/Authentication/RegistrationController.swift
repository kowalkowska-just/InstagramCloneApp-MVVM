//
//  RegistrationController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 16/03/2021.
//

import UIKit

class RegistrationController: UIViewController {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Helper Functions
    
    private func setupView() {
        view.backgroundColor = .systemPink
    }
}

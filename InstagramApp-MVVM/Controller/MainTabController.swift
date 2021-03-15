//
//  MainTabController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Helper Functions
    
    private func setupView() {
        view.backgroundColor = .blue
    }
}

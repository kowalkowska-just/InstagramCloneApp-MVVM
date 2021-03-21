//
//  MainTabController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureViewControllers()
        checkIfUserIsLoggedIn()
      //  logout()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed to sign out user")
        }
    }
    //MARK: - Helper Functions
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func configureViewControllers() {
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewcontroller: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewcontroller: SearchController())
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewcontroller: ImageSelectorController())
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewcontroller: NotificationController())
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewcontroller: ProfileController())

        viewControllers = [feed, search, imageSelector, notification, profile]
        tabBar.tintColor = .black
    }
    
    private func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewcontroller: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewcontroller)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
}

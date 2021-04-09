//
//  SearchController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    private func fetchUsers() {
        UserService.fetchUsers { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helper Functions
    
    private func configureTableView() {
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
}

//MARK: - UITableViewDataSource and UITableViewDelegate

extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}

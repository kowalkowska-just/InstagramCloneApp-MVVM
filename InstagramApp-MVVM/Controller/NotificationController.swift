//
//  NotificationController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {

    //MARK: - Properties
    
    private var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNotifications()
    }
    
    //MARK: - API
    
    private func fetchNotifications() {
        NotificationService.fetchNotification { (notifications) in
            self.notifications = notifications
            self.checkIfUserIsFollowed()
        }
    }
    
    private func checkIfUserIsFollowed() {
        notifications.forEach { notification in
            guard notification.type == .follow else { return }
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
    
    //MARK: - Helper Functions
    
    private func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let uid = notifications[indexPath.row].uid
        
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//MARK: - NotificationCellDelegate

extension NotificationController: NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFallow uid: String) {
        UserService.follow(uid: uid) { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToUnFollow uid: String) {
        UserService.unfollow(uid: uid) { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG: Show post here...")
        PostService.fetchPost(withPostId: postId) { post in
            let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            controller.post = post
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}

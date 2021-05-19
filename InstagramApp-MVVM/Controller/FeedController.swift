//
//  FeedController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {

    //MARK: - Properties
    
    private var posts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var post: Post? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
        
        if post != nil {
            checkIfUserLikedPost()
        }
    }
    
    //MARK: - Selectors
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out user")
        }
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    //MARK: - API
    
    private func fetchPosts() {
        guard post == nil else { return }
        
        PostService.fetchFeedPost { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPost()
        }
    }
    
    private func checkIfUserLikedPost() {
        
        if let post = post {
            PostService.checkIfUserLikedPost(post: post) { didLike in
                self.post?.didLike = didLike
            }
        } else {
            posts.forEach { post in
                PostService.checkIfUserLikedPost(post: post) { (didLike) in
                    if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                        self.posts[index].didLike = didLike
                    }
                }
            }
        }
    }
    
    //MARK: - Helper Functions
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
                
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(handleLogout))
            navigationItem.title = "Feed"
        } else {
            navigationItem.title = "Post"
        }

        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionVieDataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout - Setting a size of cells

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60

        return CGSize(width: width, height: height)
    }
}

//MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        
        guard let tab = tabBarController as? MainTabController else { return }
        guard let user = tab.user else { return }
        
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePost(post: post) { (error) in
                if let error = error {
                    print("DEBUG: Failed to unlike a post with error: \(error)")
                }
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
        } else {
            PostService.likePost(post: post) { (error) in
                if let error = error {
                    print("DEBUG: Failed to like a post with error: \(error)")
                }
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                
                NotificationService.uploadNotification(toUid: post.ownerUid,
                                                       fromUser: user,
                                                       type: .like,
                                                       post: post)
            }
        }
    }
    
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        
        UserService.fetchUser(withUid: uid) { (user) in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

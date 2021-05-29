//
//  ProfileController.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 15/03/2021.
//

import UIKit

enum SelectedView {
    case grid
    case list
    case bookmark
}

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"
private let reuseIdentifier = "FeedCell"
private let bookmarkIdentifier = "BookmarkIdentifier"


class ProfileController: UICollectionViewController {

    //MARK: - Properties
    
    private var user: User
    private var posts = [Post]()
    private var selectedView: SelectedView = .grid
    private var isPostsLabelTapped: Bool = false
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        configureNavigationController()
        configureCollectionView()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchPosts()
    }
    
    //MARK: - API
    
    private func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { (isFollowed) in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    private func fetchUserStats() {
        UserService.fetchUserState(uid: user.uid) { (stats) in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    private func fetchPosts() {
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: - Selectors
    
    @objc private func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    @objc private func tappedMenuButton() {
        print("DEBUG: Tapped in Menu Button..")
    }
    
    //MARK: - Helper Functions
    
    private func configureNavigationController() {
        
        //Left title
        let title = UILabel()
        title.text = user.username
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: title)
        self.navigationItem.leftBarButtonItem = leftItem
        
        //Remove border
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "white"), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //RightButton
        let barButton = UIButton()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "hamburger")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tappedMenuButton), for: .touchUpInside)
        
        barButton.addSubview(button)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: bookmarkIdentifier)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedView == .bookmark ? 1 : posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch selectedView {
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
            return cell
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
            return cell
        case .bookmark:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookmarkIdentifier, for: indexPath) as! BookmarkCell
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        return header
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
            if isPostsLabelTapped {
                UIView.animate(withDuration: 1.1) {
                    
                    guard let nav = self.navigationController else { return }
                    let heightNav = nav.navigationBar.frame.height
                    
                    self.view.frame.origin.y = 0 + heightNav * 2
                    self.isPostsLabelTapped = false
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedView == .bookmark {
            return
        }
        
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch selectedView {
        case .grid:
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        case .list:
            let viewModel = PostViewModel(post: posts[indexPath.row])
            let width = view.frame.width
            let heightCaption = viewModel.size(forWidth: width).height + 31
            let height = width + heightCaption + 126
            return CGSize(width: width, height: height)
        case .bookmark:
            let width = view.frame.width
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

//MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    
    func showPosts() {
        isPostsLabelTapped = true
        
        UIView.animate(withDuration: 1.1) {
            self.view.frame.origin.y = -96
        }
    }
    
    func showFollowers() {
        print("DEBUG: Tapped in followers label..")

    }
    
    func showFollowing() {
        print("DEBUG: Tapped in following label..")

    }
    
    func selectedListView() {
        selectedView = .list
        collectionView.reloadData()
    }
    
    func selectedGirdView() {
        selectedView = .grid
        collectionView.reloadData()
    }
    
    func selectedBookmarkView() {
        selectedView = .bookmark
        collectionView.reloadData()
    }
    
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        
        guard let tab = tabBarController as? MainTabController else { return }
        guard let currentUser = tab.user else { return }
        
        if user.isCurrentUser {
            print("DEBUG: Show edit profile here..")
        } else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { (error) in
                self.user.isFollowed = false
                self.collectionView.reloadData()
                
                PostService.updateUserFeedAfterFollowing(user: user, didFollow: false)
            }
        } else {
            UserService.follow(uid: user.uid) { (error) in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                
                NotificationService.uploadNotification(toUid: user.uid, fromUser: currentUser, type: .follow)
                
                PostService.updateUserFeedAfterFollowing(user: user, didFollow: true)
            }
        }
    }
}

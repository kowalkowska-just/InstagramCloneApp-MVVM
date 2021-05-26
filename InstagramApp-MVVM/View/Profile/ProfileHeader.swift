//
//  ProfileHeader.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
    func selectedListView()
    func selectedGirdView()
    func selectedBookmarkView()
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.tintColor = .black
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(handleChangeCurrentView(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tag = 2
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handleChangeCurrentView(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bookmark_logo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.setDimensions(height: 35, width: 35)
        button.tag = 3
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handleChangeCurrentView(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func handleEditProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
    
    @objc private func handleChangeCurrentView(sender: UIButton) {
        [gridButton, listButton, bookmarkButton].forEach { button in
            button.tintColor = UIColor(white: 0, alpha: 0.2)
        }
        
        switch sender.tag {
        case 1:
            sender.tintColor = UIColor.systemBlue
            delegate?.selectedGirdView()
        case 2:
            sender.tintColor = UIColor.systemBlue
            delegate?.selectedListView()
        case 3:
            sender.tintColor = UIColor.systemBlue
            delegate?.selectedBookmarkView()
        default:
            return
        }
    }
    
    
    //MARK: - Helper Functions
    
    private func configureView() {
        
        backgroundColor = .white
        
        //Adding subviews
        [profileImageView, nameLabel, editProfileFollowButton].forEach { subview in
            addSubview(subview)
        }
        
        //Constraints of profileImageView
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.anchor(top: topAnchor,
                                left: leftAnchor,
                                paddingTop: 12,
                                paddingLeft: 12)
        
        //nameLabel
        nameLabel.anchor(top: profileImageView.bottomAnchor,
                         left: leftAnchor,
                         paddingTop: 12,
                         paddingLeft: 12)
        
        //editProfileFollowButton
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor,
                                       left: leftAnchor,
                                       right: rightAnchor,
                                       paddingTop: 16,
                                       paddingLeft: 24,
                                       paddingRight: 24)
        
        //stack view
        let stack = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor,
                     right: rightAnchor,
                     paddingLeft: 12,
                     paddingRight: 12,
                     height: 50)
        
        //topDivider
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        //bottomDivider
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray

        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 2
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           height: 50)
        
        topDivider.anchor(top: buttonStack.topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          height: 0.5)
        
        bottomDivider.anchor(top: buttonStack.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             height: 0.5)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
        postsLabel.attributedText = viewModel.numberOfPosts
    }
}

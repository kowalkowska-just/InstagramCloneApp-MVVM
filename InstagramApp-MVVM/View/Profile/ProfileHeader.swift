//
//  ProfileHeader.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Justyna Kowalkowska"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.tintColor = .black
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowtapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel().createLabel(withValue: 9, withText: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel().createLabel(withValue: 2, withText: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel().createLabel(withValue: 1, withText: "following")
        return label
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
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
    
    @objc private func handleEditProfileFollowtapped() {
        print("DEBUG: Handle edit profile tapped..")
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
}

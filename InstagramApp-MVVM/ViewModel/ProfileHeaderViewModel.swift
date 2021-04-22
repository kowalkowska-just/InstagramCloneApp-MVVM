//
//  ProfileHeaderViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import UIKit

struct ProfileHeaderViewModel {
    
    //MARK: - Properties
    
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return user.isFollowed ? "Following" : "Follow"
        }
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, text: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, text: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStatText(value: user.stats.posts, text: "posts")
    }
    
    //MARK: - Initializer
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: - Helper Functions
    
    func attributedStatText(value: Int, text: String) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
            
        return attributedText
    }
}

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
    
    //MARK: - Initializer
    
    init(user: User) {
        self.user = user
    }
    
    
}

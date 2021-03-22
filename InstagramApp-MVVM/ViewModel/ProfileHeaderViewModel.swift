//
//  ProfileHeaderViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import Foundation

struct ProfileHeaderViewModel {
    
    //MARK: - Properties
    
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    //MARK: - Initializer
    
    init(user: User) {
        self.user = user
    }
    
    
}

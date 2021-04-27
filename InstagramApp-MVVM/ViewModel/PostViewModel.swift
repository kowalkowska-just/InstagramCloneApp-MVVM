//
//  PostViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 21/04/2021.
//

import Foundation

struct PostViewModel {
    
    //MARK: - Properties
    
    var post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    
    //MARK: - Initializer
    
    init(post: Post) {
        self.post = post
    }
}

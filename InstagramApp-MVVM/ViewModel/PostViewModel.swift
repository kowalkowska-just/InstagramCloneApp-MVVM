//
//  PostViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 21/04/2021.
//

import UIKit

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
    
    var likeImage: UIImage {
        if post.didLike {
            return #imageLiteral(resourceName: "like_selected")
        } else {
            return #imageLiteral(resourceName: "like_unselected")
        }
    }
    
    var colorLikeImage: UIColor {
        if post.didLike {
            return .red
        } else {
            return .black
        }
    }
    
    
    //MARK: - Initializer
    
    init(post: Post) {
        self.post = post
    }
}

//
//  PostViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 21/04/2021.
//

import Foundation

struct PostViewModel {
    
    //MARK: - Properties
    
    private let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    
    //MARK: - Initializer
    
    init(post: Post) {
        self.post = post
    }
}

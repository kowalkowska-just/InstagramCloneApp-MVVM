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
    
    var likeButtonImage: UIImage {
        return post.didLike ? #imageLiteral(resourceName: "like_selected") : #imageLiteral(resourceName: "like_unselected")

    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }
    
    //MARK: - Initializer
    
    init(post: Post) {
        self.post = post
    }
    
    // MARK: - Functions
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = post.caption
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

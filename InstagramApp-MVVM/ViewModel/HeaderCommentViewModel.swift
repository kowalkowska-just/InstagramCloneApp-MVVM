//
//  HeaderCommentViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 03/05/2021.
//

import UIKit

struct HeaderCommentViewModel {
    
    //MARK: - Properties
    
    private let post: Post
    
    var profileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    init(post: Post) {
        self.post = post
    }
    
    //MARK: - Functions
    
    func captionLabelText() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "\(post.ownerUsername)  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: post.caption, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributedString
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = post.caption
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

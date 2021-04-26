//
//  CommentViewModel.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 26/04/2021.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    //MARK: - Functions
    
    func commentLabelText() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "\(comment.username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributedString
    }
}

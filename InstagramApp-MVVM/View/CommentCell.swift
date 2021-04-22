//
//  CommentCell.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/04/2021.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
//    private let profileImage: UIImageView = {
//
//    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    
    private func configureUI() {
        backgroundColor = .red
    }
}

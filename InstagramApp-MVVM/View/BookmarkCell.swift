//
//  BookmarkView.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 26/05/2021.
//

import UIKit

class BookmarkCell: UICollectionViewCell {

    //MARK: - Properties
    
    private let bookmarkLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bookmark_logo")
        image.contentMode = .scaleAspectFit
        image.setDimensions(height: 85, width: 85)
        image.tintColor = UIColor.black
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos and videos of you"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "When people tag you in photos or videos, they'll appear here."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
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
        addSubview(bookmarkLogo)
        bookmarkLogo.center(inView: self)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self, topAnchor: bookmarkLogo.bottomAnchor, paddingTop: 20)
        
        addSubview(descriptionLabel)
        descriptionLabel.centerX(inView: self, topAnchor: titleLabel.bottomAnchor, paddingTop: 20)
        descriptionLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 30, paddingRight: 30)
    }
}

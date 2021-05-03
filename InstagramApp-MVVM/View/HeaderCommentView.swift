//
//  HeaderCommentView.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 30/04/2021.
//

import UIKit

class HeaderCommentView: UICollectionReusableView {
    
    //MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 40/2
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private let captionPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        
        let attributedString = NSMutableAttributedString(string: "spiderman  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: "Caption post label... ", attributes: [.font: UIFont.systemFont(ofSize: 14)]))

        label.attributedText = attributedString
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.anchor(height: 0.5)
        return view
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
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 15)
        
        addSubview(captionPostLabel)
        captionPostLabel.numberOfLines = 0
        captionPostLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 8, paddingRight: 8)
        
        addSubview(divider)
        divider.anchor(top: captionPostLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
    }
}

//
//  HeaderCommentView.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 30/04/2021.
//

import UIKit

class HeaderCommentView: UICollectionReusableView {
    
    //MARK: - Properties
    
    var viewModel: HeaderCommentViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 40/2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let captionPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.anchor(height: 1)
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
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        captionPostLabel.attributedText = viewModel.captionLabelText()
    }
    
    private func configureUI() {
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 8)
        
        addSubview(captionPostLabel)
        captionPostLabel.numberOfLines = 0
        captionPostLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 8, paddingRight: 8)
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 8)
    }
}

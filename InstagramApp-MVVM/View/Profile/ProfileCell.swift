//
//  ProfileCell.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 22/03/2021.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    
    private func configureView() {
        
        backgroundColor = .lightGray

        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }
}


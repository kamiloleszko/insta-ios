//
//  CommentCell.swift
//  InstaTut
//
//  Created by kamil on 29/06/2022.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(
            string: "Joker ",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 14)
            ]
        )
        attributedString.append(
            NSAttributedString(
                string: "Some test comment for now...",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14)
                ]
            )
        )
        label.attributedText = attributedString
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUi() {
        
        addSubview(profileImageView)
        profileImageView.centerY(
            inView: self,
            leftAnchor: leftAnchor,
            paddingLeft: 8
        )
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        
        addSubview(commentLabel)
        commentLabel.centerY(
            inView: profileImageView,
            leftAnchor: profileImageView.rightAnchor,
            paddingLeft: 8
        )
    }
}

//
//  CommentViewModel.swift
//  InstaTut
//
//  Created by kamil on 29/06/2022.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var username: String {
        return comment.username
    }
    
    var commentText: String {
        return comment.comment
    }
    
    func commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: "\(username) ",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 14)
            ]
        )
        attributedString.append(
            NSAttributedString(
                string: "\(commentText)",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14)
                ]
            )
        )
        
        return attributedString
    }
    
    // zawijanie lini komentarza przy wiekszej ilosci znakow
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.comment
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

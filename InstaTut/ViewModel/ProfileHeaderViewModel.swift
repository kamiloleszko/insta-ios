//
//  ProfileHeaderViewModel.swift
//  InstaTut
//
//  Created by kamil on 16/06/2022.
//

import UIKit

struct ProfileHeaderViewModel {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if  user.isCurrentUser {
            return "Edit profile"
        }
        
        return user.isFollowed
            ? "Following"
            : "Follow"
    }
    
    var followButtonColor: UIColor {
        return user.isCurrentUser
            ? .white
            : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser
            ? .black
            : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStateText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStateText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStateText(value: user.stats.posts, label: "posts")
    }
    
    func attributedStateText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: "\(value)\n",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 14)
            ]
        )
        
    
        attributedText.append(
            NSAttributedString(
                string: label,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.lightGray
                ]
            )
        )
        
        return attributedText
    }
}

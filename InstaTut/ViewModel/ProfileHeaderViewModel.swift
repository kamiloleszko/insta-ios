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
}

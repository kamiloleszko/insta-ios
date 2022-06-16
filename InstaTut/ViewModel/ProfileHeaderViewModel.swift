//
//  ProfileHeaderViewModel.swift
//  InstaTut
//
//  Created by kamil on 16/06/2022.
//

import Foundation

struct ProfileHeaderViewModel {
    
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}

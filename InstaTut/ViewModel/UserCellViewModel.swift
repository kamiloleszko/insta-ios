//
//  UserCellViewModel.swift
//  InstaTut
//
//  Created by kamil on 18/06/2022.
//

import Foundation

struct UserCellViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
}

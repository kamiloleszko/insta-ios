//
//  PostViewModel.swift
//  InstaTut
//
//  Created by kamil on 24/06/2022.
//

import Foundation

struct PostViewModel {
    
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likesLabelText: String {
        return post.likes != 1
        ? "\(post.likes) likes"
        : "\(post.likes) like"
    }
    
    var ownerImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var ownerUsername: String {
        return post.ownerUsername
    }
}

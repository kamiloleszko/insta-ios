//
//  PostViewModel.swift
//  InstaTut
//
//  Created by kamil on 24/06/2022.
//

import Foundation

struct PostViewModel {
    
    private let post: Post
    
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
}

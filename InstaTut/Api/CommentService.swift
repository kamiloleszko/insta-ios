//
//  CommentService.swift
//  InstaTut
//
//  Created by kamil on 29/06/2022.
//

import Firebase

class CommentService {
    
    static func uploadComment(comment: String, postId: String, user: User, completion: @escaping(FirestormCompletion)) {
        
        let data: [String: Any] = [
            "uid": user.uid,
            "comment": comment,
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "profileImageUrl": user.profileImageUrl
        ]
        
        COLLECTION_POSTS
            .document(postId)
            .collection(COMMENTS_COLLECTION_NAME)
            .addDocument(data: data, completion: completion)
    }
    
    static func fetchComments() {
        
    }
    
}

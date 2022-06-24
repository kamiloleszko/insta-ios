//
//  PostService.swift
//  InstaTut
//
//  Created by kamil on 24/06/2022.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestormCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerUid": uid
            ] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.getDocuments() { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            let posts = documents.map({
                Post(postId: $0.documentID, dictionary: $0.data())
            })
            completion(posts)
        }
    }
}

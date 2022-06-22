//
//  UserService.swift
//  InstaTut
//
//  Created by kamil on 12/06/2022.
//

import Firebase

typealias FirestormCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let users = snapshot.documents.map({User(dictionary: $0.data())})
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestormCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection(USER_FOLLOWING_COLLECTION_NAME)
            .document(uid)
            .setData([:]) { error in
                COLLECTION_FOLLOWERS
                    .document(uid)
                    .collection(USER_FOLLOWERS_COLLECTION_NAME)
                    .document(currentUid)
                    .setData([:], completion: completion)
            }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestormCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection(USER_FOLLOWING_COLLECTION_NAME)
            .document(uid)
            .delete { error in
                COLLECTION_FOLLOWERS
                    .document(uid)
                    .collection(USER_FOLLOWERS_COLLECTION_NAME)
                    .document(currentUid)
                    .delete(completion: completion)
            }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}

        COLLECTION_FOLLOWING
            .document(currentUid)
            .collection(USER_FOLLOWING_COLLECTION_NAME)
            .document(uid)
            .getDocument{ (snapshot, error) in
                guard let isFollowed = snapshot?.exists else {return}
                completion(isFollowed)
            }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS
            .document(uid)
            .collection(USER_FOLLOWERS_COLLECTION_NAME)
            .getDocuments{ (snapshot, _) in
                let followers = snapshot?.documents.count ?? 0
                
                COLLECTION_FOLLOWING
                    .document(uid)
                    .collection(USER_FOLLOWING_COLLECTION_NAME)
                    .getDocuments{ (snapshot, _) in
                        let following = snapshot?.documents.count ?? 0
                        completion(UserStats(followers: followers, following: following))
                    }
                }
    }
}
    


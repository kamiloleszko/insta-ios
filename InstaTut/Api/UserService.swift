//
//  UserService.swift
//  InstaTut
//
//  Created by kamil on 12/06/2022.
//

import Firebase

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
}

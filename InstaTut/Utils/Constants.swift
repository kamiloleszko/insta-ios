//
//  Constants.swift
//  InstaTut
//
//  Created by kamil on 12/06/2022.
//

import Firebase

let USER_FOLLOWERS_COLLECTION_NAME = "user-followers"
let USER_FOLLOWING_COLLECTION_NAME = "user-following"

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")


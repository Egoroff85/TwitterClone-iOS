//
//  User.swift
//  TwitterClone
//
//  Created by WiCKed on 03.01.2022.
//

import Foundation
import Firebase

struct User {
    var fullname: String
    let email: String
    var username: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    var bio: String?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let bio = dictionary["bio"] as? String {
            self.bio = bio
        }
        if let profileImageString = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = URL(string: profileImageString)
        }        
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}

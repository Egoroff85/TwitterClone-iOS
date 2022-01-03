//
//  User.swift
//  TwitterClone
//
//  Created by WiCKed on 03.01.2022.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageString = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = URL(string: profileImageString)
        }        
    }
}

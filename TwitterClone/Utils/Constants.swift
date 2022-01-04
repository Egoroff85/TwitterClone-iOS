//
//  Constants.swift
//  TwitterClone
//
//  Created by WiCKed on 27.12.2021.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

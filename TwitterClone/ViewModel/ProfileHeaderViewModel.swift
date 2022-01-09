//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by WiCKed on 07.01.2022.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    // MARK: - Properties
    
    private let user: User
    
    let usernameText: String
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "following")
    }
    
    var actionButtonTitle: String {
        // if user is current user then set to edit profile
        // else figure out following data
        if user.isCurrentUser {
            return "Edit Profile"
        }
        if user.isFollowed {
            return "Follow"
        } else {
            return "Following"
        }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        self.usernameText = "@" + user.username
    }
    
    // MARK: - Helpers
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                                  attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}

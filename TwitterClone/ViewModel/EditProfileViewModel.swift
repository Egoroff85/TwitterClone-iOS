//
//  EditProfileViewModel.swift
//  TwitterClone
//
//  Created by WiCKed on 30.01.2022.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullname:
            return "Name"
        case .username:
            return "Username"
        case .bio:
            return "Bio"
        }
    }
}

struct EditProfileViewModel {
    // MARK: - Properties
    
    private let user: User
    let option: EditProfileOptions
    
    var shouldHideTextField: Bool {
        return option == .bio
    }
    
    var shouldHideTextView: Bool {
        return option != .bio
    }
    
    var titleText: String {
        return option.description
    }
    
    var shouldHideBioPlaceholder: Bool {
        return user.bio != nil
    }
    
    var optionValue: String? {
        switch option {
        case .fullname:
            return user.fullname
        case .username:
            return user.username
        case .bio:
            return user.bio
        }
    }
    
    // MARK: - Lifecycle
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}

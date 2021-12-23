//
//  MainTabController.swift
//  TwitterClone
//
//  Created by WiCKed on 21.12.2021.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }

    func configureViewControllers() {
        let feed = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: FeedController())
        let explore = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreController())
        let notifications = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsController())
        let conversations = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationsController())
        
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        
    }
}

//
//  MainTabController.swift
//  TwitterClone
//
//  Created by WiCKed on 21.12.2021.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?.first as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
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
//        logUserOut()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            // когда нужно отобразить вью контроллер в момент загрузки другого, нужно использовать главный поток, иначе не работает
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                // чтобы контроллер отобразился на весь экран и его нельзя было закрыть свайпом сверху вниз:
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
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
        guard let user = user else {
            return
        }
        let nav = UINavigationController(rootViewController: UploadTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

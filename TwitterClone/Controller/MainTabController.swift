//
//  MainTabController.swift
//  TwitterClone
//
//  Created by WiCKed on 21.12.2021.
//

import UIKit
import Firebase

enum ActionButtonConfiguration {
    case tweet
    case message
}

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    private var buttonConfig: ActionButtonConfiguration = .tweet
    
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
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
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
    
    // MARK: - Helpers
    
    func configureUI() {
        self.delegate = self
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }

    func configureViewControllers() {
        let feed = templateNavigationController(image: UIImage(named: "home_unselected"),
                                                rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        let explore = templateNavigationController(image: UIImage(named: "search_unselected"),
                                                   rootViewController: ExploreController(config: .userSearch))
        let notifications = templateNavigationController(image: UIImage(named: "like_unselected"),
                                                         rootViewController: NotificationsController())
        let conversations = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"),
                                                         rootViewController: ConversationsController())
        
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
        guard let user = user else { return }
        let controller: UIViewController
        
        switch buttonConfig {
        case .tweet:
            controller = UploadTweetController(user: user, config: .tweet)
        case .message:
            controller = ExploreController(config: .messages)
        }

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = viewControllers?.firstIndex(of: viewController)
        let image = index == 3 ? #imageLiteral(resourceName: "mail") : #imageLiteral(resourceName: "new_tweet")
        actionButton.setImage(image, for: .normal)
        buttonConfig = index == 3 ? .message : .tweet
    }
}

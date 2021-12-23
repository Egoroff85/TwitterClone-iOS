//
//  NotificationsController.swift
//  TwitterClone
//
//  Created by WiCKed on 21.12.2021.
//

import UIKit

class NotificationsController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }

}

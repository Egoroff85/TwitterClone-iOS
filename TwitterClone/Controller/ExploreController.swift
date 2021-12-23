//
//  ExploreController.swift
//  TwitterClone
//
//  Created by WiCKed on 21.12.2021.
//

import UIKit

class ExploreController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
    
}

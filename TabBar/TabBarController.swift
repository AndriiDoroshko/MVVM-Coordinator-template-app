//
//  TabBarController.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = UIColor.systemGray
        tabBar.isTranslucent = true
    }
}

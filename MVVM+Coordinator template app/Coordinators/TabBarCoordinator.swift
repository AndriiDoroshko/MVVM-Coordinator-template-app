//
//  TabBarCoordinator.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    // Needed in case we make a decision to have additional coordinator for new feature
    let parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController : UINavigationController,
         parentCoordinator: Coordinator? = nil,
         children: [Coordinator] = []) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator() // Do not pass navigationController to HomeCoordinator initializer
        children.append(homeCoordinator)
        children.forEach { $0.start() }
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [homeCoordinator.navigationController]
        
        navigationController.setViewControllers([tabBarController],
                                                animated: true)
    }
}


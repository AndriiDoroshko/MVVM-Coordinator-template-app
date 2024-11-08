//
//  AppCoordinator.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation
import UIKit

enum Screen {
    case home
}

class AppCoordinator: Coordinator {
    // Needed in case we make a decision to have additional coordinator for new feature
    let parentCoordinator: Coordinator?
    let children: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController : UINavigationController,
         parentCoordinator: Coordinator? = nil,
         children: [Coordinator] = []) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        navigationController.navigationBar.isHidden = true
        navigateToHomeIfPossible()
    }
    
    func navigateToHomeIfPossible() {
        // App launched and we are going to define if user loged in. Meanwhile we are displaing launch screen
        let launchScreenCoordinator = LaunchScreenCoordinator(navigationController: self.navigationController,
                                                              parentCoordinator: self)
        launchScreenCoordinator.start()
        
        // Replace Timer with network request to check if user is loged in. If Not then use Login Coordinator
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let tabBarCoordinator = TabBarCoordinator(
                navigationController: self.navigationController,
                parentCoordinator: self)
            tabBarCoordinator.start()
        }
    }
}


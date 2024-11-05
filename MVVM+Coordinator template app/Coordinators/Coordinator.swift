//
//  Coordinator.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get }
    var children: [Coordinator] { get }
    
    var navigationController : UINavigationController { get }
    
    func start()
}

//
//  CoreCoordinator.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/29.
//

import Foundation
import UIKit

class CoreCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        homeCoordinator.start()
    }
}

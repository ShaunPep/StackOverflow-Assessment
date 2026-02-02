//
//  HomeCoordinator.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/29.
//

import Foundation
import UIKit

class HomeCoordinator {
    private let navigationController: UINavigationController
//    private let apiClient: ApiClient
    
    //Add service here with default init
    init(navigationController: UINavigationController, apiClient: ApiClient = ApiClient()) {
        self.navigationController = navigationController
//        self.apiClient = apiClient
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("HomeViewController not found")
        }
        
//        let viewModel = HomeViewModel(with: apiClient)
//        let viewModel = HomeViewModel(with: SearchResultsRepository())
        let viewModel = StackOverflowItemsViewModel(repository: SearchResultsRepository())
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showDetails(for item: StackOverflowQuestion) {
        let storyboard = UIStoryboard(name: "StackOverflowItemDetails", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "StackOverflowItemDetailsViewController") as? StackOverflowItemDetailsViewController else {
            fatalError("Not found")
        }
        //This must become some view model with the data
//        viewController.viewModel = StackOverflowDetailsViewModel(with: item, repository: AnswersRepository())
        viewController.viewModel = StackOverflowItemsViewModel(repository: AnswersRepository())
        viewController.question = item
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  AnswersRepository.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

import Foundation

protocol AnswersDataSource: AnyObject {
    func answersRecieved()
}

class AnswersRepository: StackOverflowItemsRepositoryProtocol {
    private let apiClient = ApiClient()
    
    weak var datasource: SearchResultsDataSource!
    var results: [StackOverflowAnswer]?
    
    func fetchItems(_ query: String) async throws {
        let endpoint = StackOverflowEndpoint.getDetails(query)
        
        do {
            let responseData: StackOverflowItems<StackOverflowAnswer> = try await apiClient.request(with: endpoint)
            
            results = responseData.items
            datasource.searchResultsRecieved()
        } catch {
            
        }
    }
    
    func getNumberOfResults() -> Int {
        if let numberOfResults = results?.count {
            return numberOfResults + 1
        }
        
        return 1
    }
    
    func getItem(at index: Int) -> StackOverflowAnswer {
        return results![index - 1]
    }
}

//
//  SearchResultsRepository.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

protocol SearchResultsDataSource: AnyObject {
    func searchResultsRecieved()
}

class SearchResultsRepository: StackOverflowItemsRepositoryProtocol {
    private let apiClient = ApiClient()
    
    weak var datasource: SearchResultsDataSource!
    var results: [StackOverflowQuestion]?
    
    func fetchItems(_ query: String) async throws {
        let endpoint: Endpoint = StackOverflowEndpoint.search(query)
        
        do {
            let responseData: StackOverflowItems<StackOverflowQuestion> = try await apiClient.request(with: endpoint)
            results = responseData.items
            
            datasource.searchResultsRecieved()
        } catch {
            throw error
        }
    }
    
    func getNumberOfResults() -> Int {
        return results?.count ?? 0
    }
    
    func getItem(at index: Int) -> StackOverflowQuestion {
        return results![index]
    }
}

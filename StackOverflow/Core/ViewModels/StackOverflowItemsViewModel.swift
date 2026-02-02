//
//  StackOverflowItemsViewModel.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/02/01.
//

import Foundation

protocol StackOverflowItemsViewModelDelegate: AnyObject {
    func dataHasChanged()
    func didReceiveError()
}

class StackOverflowItemsViewModel<R: StackOverflowItemsRepositoryProtocol> {
    private var repository: R
    
    weak var delegate: StackOverflowItemsViewModelDelegate!
    var errorMessage: String?
    
    init(repository: R) {
        self.repository = repository
        self.repository.datasource = self
    }
    
    func getItems(with value: String) {
        Task {
            do {
                try await repository.fetchItems(value)
            } catch ApiError.invalidURL {
                errorMessage = "Invalid URL"
                delegate.didReceiveError()
            } catch ApiError.httpError(let message) {
                errorMessage = message
                delegate.didReceiveError()
            } catch ApiError.invalidResponse {
                errorMessage = "Invalid response returned from service"
                delegate.didReceiveError()
            } catch ApiError.decodingError(let error) {
                errorMessage = error.localizedDescription
                delegate.didReceiveError()
            } catch ApiError.noNetwork {
                errorMessage = "You are currently offline"
                delegate.didReceiveError()
            }
        }
    }
    
    func numberOfItems() -> Int {
        return repository.getNumberOfResults()
    }
    
    func item(at index: Int) -> R.Item {
        return repository.getItem(at: index)
    }
}

extension StackOverflowItemsViewModel: SearchResultsDataSource {
    func searchResultsRecieved() {
        delegate.dataHasChanged()
    }
}

//
//  StackOverflowItemsRepositoryProtocol.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/02/01.
//

import Foundation

protocol StackOverflowItemsRepositoryProtocol {
    associatedtype Item: Decodable
    
    var datasource: SearchResultsDataSource! { get set }
    var results: [Item]? { get }
    
    func fetchItems(_ query: String) async throws
    func getNumberOfResults() -> Int
    func getItem(at index: Int) -> Item
}

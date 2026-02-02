//
//  ApiClient.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

class ApiClient {
    private let networkMonitor = NetworkMonitor.shared
    
    private func decodeResponseData<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
    
    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        if !networkMonitor.isConnected {
            throw ApiError.noNetwork
        }
        
        guard var urlComponents = URLComponents(string: endpoint.baseURL) else {
            throw ApiError.invalidURL
        }
        
        urlComponents.path += endpoint.path
        urlComponents.queryItems = endpoint.queryParameters
        
        guard let url = urlComponents.url else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw ApiError.httpError(message: "An error occured: Status code \(httpResponse.statusCode)")
        }
        
        let responseObject: T = try decodeResponseData(data: data)
        
        return responseObject
    }
}

//
//  EndpointProtocol.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethodTypes { get }
    var headers: [String: String]? { get }
    var queryParameters: [URLQueryItem]? { get }
}

extension Endpoint {
    var baseURL: String {
        #if DEBUG
        return ProcessInfo.processInfo.environment["STACKOVERFLOW_BASE_URL"] ?? ""
        #else
        return ""
        #endif
    }
    
    var headers: [String: String]? {
        return nil
    }
}

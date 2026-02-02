//
//  StackOverflowEndpoint.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

enum StackOverflowEndpoint: Endpoint {
    case search(_ title: String)
    case getDetails(_ questionId: String)
    
    var path: String {
        switch self {
        case .search:
            return "/2.2/search/advanced?"
        case .getDetails(let questionId):
            return "/2.2/questions/\(questionId)/answers"
        }
    }
    
    var method: HttpMethodTypes {
        return .get
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .search(let title):
            return [URLQueryItem(name: "pagesize", value: "20"), URLQueryItem(name: "order", value: "desc"), URLQueryItem(name: "sort", value: "activity"), URLQueryItem(name: "title", value: title), URLQueryItem(name: "site", value: "stackoverflow"), URLQueryItem(name: "filter", value: "withbody")]
        case .getDetails:
            return [URLQueryItem(name: "order", value: "desc"), URLQueryItem(name: "sort", value: "activity"), URLQueryItem(name: "site", value: "stackoverflow"), URLQueryItem(name: "filter", value: "withbody")]
        }
    }
}

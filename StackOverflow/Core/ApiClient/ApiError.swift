//
//  ApiError.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

enum ApiError: Error {
    case noNetwork
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case httpError(message: String)
}

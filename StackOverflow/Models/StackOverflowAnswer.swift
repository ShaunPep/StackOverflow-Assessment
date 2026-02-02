//
//  StackOverflowItemDetails.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

struct StackOverflowAnswer: Decodable {
    let body: String
    let owner: StackOverflowItemOwner
    let score: Int
    let is_accepted: Bool
}

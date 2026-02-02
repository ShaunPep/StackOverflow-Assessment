//
//  StackOverflowItem.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/30.
//

import Foundation

struct StackOverflowQuestion: Decodable {
    let title: String
    let body: String
    let owner: StackOverflowItemOwner
    let view_count: Int
    let answer_count: Int
    let score: Int
    let is_answered: Bool
    let creation_date: Double
    let question_id: Int
}

//
//  StackOverflowItems.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/02/01.
//

import Foundation

struct StackOverflowItems<T: Decodable>: Decodable {
    let items: [T]
}

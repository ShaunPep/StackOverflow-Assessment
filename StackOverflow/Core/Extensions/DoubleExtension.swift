//
//  DoubleExtension.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/02/01.
//

import Foundation

extension Double {
    func toDate(with format: String) -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

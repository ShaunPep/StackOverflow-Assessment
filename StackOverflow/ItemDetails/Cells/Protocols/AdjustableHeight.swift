//
//  AdjustableHeight.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

import Foundation

protocol AdjustableHeight: AnyObject {
    func onHeightUpdated(height: CGFloat, index: Int)
}

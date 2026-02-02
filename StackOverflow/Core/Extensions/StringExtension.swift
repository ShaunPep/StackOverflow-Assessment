//
//  StringExtension.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

import Foundation

extension String {
    func stripHTML() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression).replacingOccurrences(of: "&nbsp;", with: " ")
    }
    
    func wrappedInHTML() -> String {
            """
            <html>
            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    html, body 
                    {
                        margin: 0;
                        padding: 0;
                    }
            
                    p {
                        margin: 0;
                    }
            
                    img {
                        max-width: 100%;
                        height: auto;
                    }
                </style>
            </head>
            <body>
                \(self)
            </body>
            </html>
            """
        }
}

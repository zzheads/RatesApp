//
//  APIError.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

enum APIError: Error {
    static let domain = "Currency's rates API Error"
    
    case badURL(date: Date)
    
    var description: String {
        switch self {
        case .badURL(let date)  : return "Can't construct url request rates for date: \(date)"
        }
    }

    var statusCode: Int {
        switch self {
        case .badURL(_)         : return 401
        }
    }
    
    var error: NSError {
        return NSError(domain: APIError.domain, code: self.statusCode, userInfo: [NSLocalizedDescriptionKey: self.description])
    }
}

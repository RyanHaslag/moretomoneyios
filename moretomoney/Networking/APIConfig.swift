//
//  APIConfig.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation

struct APIConfig {
    static let environment: APIEnvironment = .production
    static var host: String {
        switch environment {
          case .production: return "https://moretomoney.com"
          case .staging: return "https://staging.moretomoney.com"
        }
    }
}

enum APIEnvironment {
    case production
    case staging
}

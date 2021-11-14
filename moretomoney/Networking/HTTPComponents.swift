//
//  HTTPComponents.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation

typealias BodyParameters = [String: String]
typealias HTTPHeaders = [String: String]
typealias QueryParameters = [String: String]

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

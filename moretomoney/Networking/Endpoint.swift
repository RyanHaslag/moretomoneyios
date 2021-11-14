//
//  Endpoint.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation

protocol Endpoint {
    //Host where we want to make the API call
    var host: String { get }
    //API call path
    var path: String { get }
    var url: URL? { get }

    //Headers specific to the endpoint
    var headers: HTTPHeaders? { get }
    //GET, POST, PATCH, PUT, DELETE
    var httpMethod: HTTPMethod { get }
  
    //Type of network call
    var task: HTTPTask { get }
}

extension Endpoint {
    var host: String { APIConfig.host }
    var url: URL? { URL(string: "\(host)\(path)") }
    var headers: HTTPHeaders? { nil }
}

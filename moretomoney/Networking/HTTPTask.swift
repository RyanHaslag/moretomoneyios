//
//  HTTPTask.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation

enum HTTPTask {
    case request(body: BodyParameters? = nil, query: QueryParameters? = nil, additionalHeaders: HTTPHeaders? = nil)
}

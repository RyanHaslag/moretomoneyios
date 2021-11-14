//
//  RequestError.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/13/21.
//

import Foundation

enum RequestError: String, Error {
    case invalidParameters = "Invalid parameters"
    case invalidURL = "Invalid url"
}

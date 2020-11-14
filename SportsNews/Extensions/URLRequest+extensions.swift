//
//  URLRequest+extensions.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

extension URLRequest {
    enum HTTPMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }

    var method: HTTPMethod? {
        get {
            guard let method = httpMethod else { return nil }
            return HTTPMethod(rawValue: method)
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }
}

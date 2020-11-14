//
//  Request.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

enum Request {
    case results

    /// The `URLRequest` object that should be passed to the `URLSession`
        var urlRequest: URLRequest {
            let urlPath = [baseURLString, path].joined(separator: "/")
            guard let url = URL(string: urlPath) else {
                fatalError("Unable to create url from \(urlPath)")
            }

            var request = URLRequest(url: url)
            request.method = method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }

        private var baseURLString: String {
            switch self {
            case .results:
                return "https://ancient-wood-1161.getsandbox.com:443"
            }
        }

        private var path: String {
            switch self {
            case .results:
                return "results"
            }
        }

        private var method: URLRequest.HTTPMethod {
            switch self {
            case .results:
                return .post
            }
        }
}

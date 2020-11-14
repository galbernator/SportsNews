//
//  SNDateFormatter.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

enum Format: String {
    case server = "MMMM d, yyyy h:mm:ss a"
    case headline = "YYYY-MM-dd"
    case filter = "MMM dd YYYY"
}

final class SNDateFormatter {
    static var shared = SNDateFormatter()
    private init() {}

    lazy var formatter: DateFormatter = {
        DateFormatter()
    }()

    static func with(format: Format) -> DateFormatter {
        let dateFormatter = shared.formatter
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }
}

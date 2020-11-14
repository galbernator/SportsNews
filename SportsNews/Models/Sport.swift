//
//  Sport.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/14/20.
//

import Foundation

enum Sport: String, CaseIterable {
    case f1 = "Formula 1"
    case nba = "NBA"
    case tennis = "Tennis"

    var iconName: String {
        switch self {
        case .f1:
            return "square.fill"
        case .nba:
            return "circle.fill"
        case .tennis:
            return "triangle.fill"
        }
    }

    // Note: When adding a new Sport, a custom color set will need to be added to the assets
    var iconColor: String {
        switch self {
        case .f1:
            return "red"
        case .nba:
            return "orange"
        case .tennis:
            return "yellow"
        }
    }
}

extension Sport: Selectable {
    var title: String {
        rawValue
    }
}

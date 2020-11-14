//
//  NewsResult.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

struct NewsResult: Decodable {
    let formula1: [F1Result]
    let nba: [NBAResult]
    let tennis: [TennisResult]

    enum CodingKeys: String, CodingKey {
        case formula1 = "f1Results"
        case nba = "nbaResults"
        case tennis = "Tennis"
    }

    var headlines: [Headlineable] {
        let results: [Headlineable] = formula1 + nba + tennis
        return results.sorted(by: { $0.publicationDate > $1.publicationDate })
    }
}

extension NewsResult {
    static var example: NewsResult {
        NewsResult(formula1: [F1Result.example], nba: [NBAResult.example], tennis: [TennisResult.example])
    }
}

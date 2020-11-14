//
//  TennisResult.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

struct TennisResult: Headlineable, Decodable {
    let publicationDate: Date
    let tournament: String
    let winner: String
    let looser: String
    let numberOfSets: Int

    var headline: String {
        "\(tournament): \(winner) wins against \(looser) in \(numberOfSets) sets"
    }

    var sport: Sport {
        .tennis
    }
}

extension TennisResult {
    static var example: TennisResult {
        TennisResult(publicationDate: Date(), tournament: "Wimbledon Jr.", winner: "Venus Williams", looser: "Steve Galbraith", numberOfSets: 3)
    }
}

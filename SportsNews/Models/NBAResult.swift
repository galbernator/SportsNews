//
//  NBAResult.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

struct NBAResult: Headlineable, Decodable {
    let publicationDate: Date
    let tournament: String
    let winner: String
    let gameNumber: Int
    let looser: String
    let mvp: String

    var headline: String {
        "\(mvp) leads \(winner) to game \(gameNumber) win in the \(tournament)"
    }

    var sport: Sport {
        .nba
    }
}

extension NBAResult {
    static var example: NBAResult {
        NBAResult(publicationDate: Date(), tournament: "All-Star Game", winner: "Team Labron", gameNumber: 1, looser: "Team Zion", mvp: "Daffy Duck")
    }
}

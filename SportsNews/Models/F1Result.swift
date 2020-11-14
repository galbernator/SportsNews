//
//  F1Result.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

struct F1Result: Headlineable, Decodable {
    let publicationDate: Date
    let tournament: String
    let winner: String
    let seconds: Double

    var headline: String {
        "\(winner) wins \(tournament) by \(seconds) seconds"
    }

    var sport: Sport {
        .f1
    }
}


extension F1Result {
    static var example: F1Result {
        F1Result(publicationDate: Date(), tournament: "Indy 500", winner: "Ricky Bobby", seconds: 101.5)
    }
}

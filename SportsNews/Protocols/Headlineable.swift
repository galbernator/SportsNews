//
//  SportResult.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

protocol Headlineable {
    var publicationDate: Date { get }
    var headline: String { get }
    var sport: Sport { get }
}

//
//  EventHandler.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation

protocol EventHandler {
    associatedtype Event
    func send(_ event: Event)
}

extension EventHandler {
    func send(_ event: DefaultEvent) {
        fatalError("Implemetation of send(_ event) needs to be implemented in the conforming class")
    }
}

enum DefaultEvent {
    case defaultImplementation
}

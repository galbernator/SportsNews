//
//  Date+extensions.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/14/20.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1

        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    func isSameDay(as date: Date) -> Bool {
        (startOfDay...endOfDay) ~= date
    }
}

extension Date: Selectable {
    var title: String {
        let dateFormatter = SNDateFormatter.with(format: .filter)
        return dateFormatter.string(from: self)
    }
}

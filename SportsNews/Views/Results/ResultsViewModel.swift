//
//  ResultsViewModel.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation
import Combine

enum FilterType: Hashable {
    case date(Date)
    case sport(Sport)

    var name: String {
        switch self {
        case .date:
            return "Date"
        case .sport:
            return "Sport"
        }
    }
}

final class ResultsViewModel: ObservableObject {
    @Published var visibleResults = [Headlineable]()
    @Published var currentFilter: FilterType

    var selectedItem: Selectable
    private let results: [Headlineable]
    private var previouslySelectedSport: Sport = Sport.allCases[0]
    private var previouslySelectedDate = Date()
    private var cancellables = Set<AnyCancellable>()
    private lazy var uniqueDates: [Date] = {
        return Array(
            results.reduce(into: [Date: Headlineable]()) { accumulator, result in
                let components = Calendar.current.dateComponents([.year, .month, .day], from: result.publicationDate)
                if let date = Calendar.current.date(from: components) {
                    accumulator[date] = result
                }
            }.keys
        ).sorted(by: { $0 > $1 })
    }()

    var title: String {
        let filterDetail: String
        switch currentFilter {
        case .date(let date):
            let dateFormatter = SNDateFormatter.with(format: .headline)
            filterDetail = dateFormatter.string(from: date)
        case .sport(let sport):
            filterDetail = sport.rawValue
        }

        return "Results for \(filterDetail)"
    }

    var filterOptions: [FilterType] {
        switch currentFilter {
        case .date:
            return [currentFilter, .sport(previouslySelectedSport)]
        case .sport:
            return [.date(previouslySelectedDate), currentFilter]
        }
    }

    var selectionOptions: [Selectable] {
        switch currentFilter {
        case .date:
            return uniqueDates
        case .sport:
            return Sport.allCases
        }
    }

    var isSelectedItemFirstOrLast: Bool {
        selectedItem.title == selectionOptions.first?.title || selectedItem.title == selectionOptions.last?.title
    }

    init(for newsResult: NewsResult) {
        results = newsResult.headlines
        let initialDate = results.first?.publicationDate ?? Date()
        currentFilter = .date(initialDate)
        selectedItem = initialDate

        setupSubscriptions()
    }

    private func setupSubscriptions() {
        $currentFilter
            .compactMap { [weak self] in self?.visibleResults(for: $0) }
            .assign(to: &$visibleResults)

        $currentFilter
            .sink { [weak self] filter in
                switch filter {
                case .date(let date):
                    self?.previouslySelectedDate = date
                    self?.selectedItem = date
                case .sport(let sport):
                    self?.previouslySelectedSport = sport
                    self?.selectedItem = sport
                }
            }
            .store(in: &cancellables)
    }

    private func visibleResults(for filter: FilterType) -> [Headlineable] {
        switch filter {
        case .date(let date):
            return results.filter { $0.publicationDate.isSameDay(as: date) }
        case .sport(let sport):
            return results.filter { $0.sport == sport }
        }
    }

    func updateFilter(with item: Selectable) {
        switch item {
        case let date as Date:
            currentFilter = .date(date)
        case let sport as Sport:
            currentFilter = .sport(sport)
        default:
            break
        }
    }
}

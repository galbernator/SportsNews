//
//  ResultsCoordinator.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

final class ResultsCoordinator {
    let viewModel: ResultsViewModel

    init(viewModel: ResultsViewModel) {
        self.viewModel = viewModel
    }

    func filterView() -> AnyView {
        FilterView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}

extension ResultsCoordinator: Coordinator {
    func start() -> AnyView {
        ResultsView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}

extension ResultsCoordinator: EventHandler {
    enum Event {
        case filter(by: Selectable)
    }

    func send(_ event: Event) {
        switch event {
        case .filter(let item):
            viewModel.updateFilter(with: item)
        }
    }
}

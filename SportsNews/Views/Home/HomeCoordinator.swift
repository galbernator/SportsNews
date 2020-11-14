//
//  HomeCoordinator.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

final class HomeCoordinator {
    let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func alert(for error: NetworkRequestError) -> Alert {
        let message: String
        switch error {
        case .error:
            message = "Something went wrong. Please find the developer and give them a good flogging."
        case .invalidStatusCode:
            message = "There appears to be something wrong with the server. Please try again later."
        }

        return Alert(
            title: Text("Uh Oh...."),
            message: Text(message),
            dismissButton: .default(Text("OK"))
        )
    }
}

extension HomeCoordinator: Coordinator {
    func start() -> AnyView {
        HomeView(viewModel: viewModel, coordinator: self).eraseToAnyView()
    }
}

extension HomeCoordinator: EventHandler {
    enum Event {
        case fetchResults
        case onDisappear
    }

    func send(_ event: Event) {
        switch event {
        case .fetchResults:
            viewModel.fetchResults()
        case .onDisappear:
            viewModel.isLoading = false
        }
    }
}

extension HomeCoordinator: Navigator {
    enum Destination {
        case results
    }

    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .results:
            return LazyView { () -> AnyView in
                guard let results = self.viewModel.results.value else {
                    fatalError("The results view should not be displayed if there are no results!")
                }

                let viewModel = ResultsViewModel(for: results)
                let coordinator = ResultsCoordinator(viewModel: viewModel)

                return coordinator.start()
            }
            .eraseToAnyView()
        }
    }
}

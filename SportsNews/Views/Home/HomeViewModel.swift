//
//  HomeViewModel.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var shouldNavigate = false
    @Published var error: NetworkRequestError?
    private var cancellables = Set<AnyCancellable>()
    private(set) var results = CurrentValueSubject<NewsResult?, Never>(nil)

    // MARK: - Lifecycle

    init() {
        setupSubscriptions()
    }

    // MARK: - Setup

    private func setupSubscriptions() {
        results
            .compactMap { $0 }
            .map { _ in true }
            .assign(to: &$shouldNavigate)
    }

    func fetchResults() {
        isLoading = true
        sendRequest()
    }

    func sendRequest() {
        // TODO: Abstract the RequestManager so that we can use dependency injection and make this testsable
        RequestManager.send(.results)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                default:
                    break
                }
            } receiveValue: { [weak self] (results: NewsResult) in
                DispatchQueue.main.async {
                    self?.results.send(results)
                }
            }
            .store(in: &cancellables)
    }
}

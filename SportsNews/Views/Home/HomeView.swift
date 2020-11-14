//
//  HomeView.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var coordinator: HomeCoordinator

    var body: some View {
        VStack {
            Button(
                action: { self.coordinator.send(.fetchResults) },
                label: {
                    if viewModel.isLoading {
                        ProgressView()

                    } else {
                        Text("Get Results")
                            .frame(maxWidth: 300, minHeight: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                    }

                }
            )
            .cornerRadius(8)

            NavigationLink(
                destination: self.coordinator.view(for: .results),
                isActive: $viewModel.shouldNavigate,
                label: { EmptyView() }
            )
        }
        .alert(item: $viewModel.error) {
            self.coordinator.alert(for: $0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        let coordinator = HomeCoordinator(viewModel: viewModel)

        return HomeView(viewModel: viewModel, coordinator: coordinator)
    }
}

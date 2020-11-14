//
//  ResultsView.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ResultsViewModel
    let coordinator: ResultsCoordinator

    @State var isFiltering = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.title)
                    .font(.title)
                    .padding(.leading)

                Spacer()

                filterButton
            }

            Divider().padding(.vertical, 0)

            if isFiltering {
                Group {
                    self.coordinator.filterView()
                        .padding(0)

                    Divider().padding(.vertical, 0)
                }
            }

            ScrollView {
                LazyVStack {
                    ForEach(viewModel.visibleResults, id: \.headline) { result in
                        VStack(spacing: 0) {
                            ResultsRow(result: result)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Divider().padding(.vertical, 0)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                self.filterButton
            }
        }
    }

    private var filterButton: Button<AnyView> {
        Button(
            action: {
                withAnimation {
                    isFiltering.toggle()
                }
            },
            label: {
                Group {
                    isFiltering ? Text(Image(systemName: "xmark.circle")).padding() : Text("Filter").padding()
                }
                .animation(.none)
                .frame(width: 72)
                .eraseToAnyView()
            }
        )
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let results = NewsResult.example
        let viewModel = ResultsViewModel(for: results)
        let coordinator = ResultsCoordinator(viewModel: viewModel)

        return NavigationView {
            ResultsView(viewModel: viewModel, coordinator: coordinator)
        }
    }
}

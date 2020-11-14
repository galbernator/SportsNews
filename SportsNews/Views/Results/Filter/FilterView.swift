//
//  FilterView.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/14/20.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: ResultsViewModel
    let coordinator: ResultsCoordinator

    var body: some View {
        VStack(spacing: 0) {
            Picker(selection: $viewModel.currentFilter, label: Text("")) {
                ForEach(viewModel.filterOptions, id: \.name) { option in
                    Text(option.name)
                        .font(.system(size: 21.0))
                        .tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .cornerRadius(0)

            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    LazyHStack(spacing: 4) {
                        ForEach(viewModel.selectionOptions, id: \.title) { selectableItem in
                            FilterPill(item: selectableItem, isSelected: isSelected(selectableItem))
                                .padding(.vertical, 2)
                                .padding(.horizontal, 4)
                                .offset(y: -1)
                                .onTapGesture {
                                    self.coordinator.send(.filter(by: selectableItem))
                                }
                        }
                    }
                    .onReceive(viewModel.$currentFilter) { _ in
                        let anchor: UnitPoint? = viewModel.isSelectedItemFirstOrLast ? nil : .center
                        withAnimation{
                            // TODO: Fix this so that it scrolls to the selection when the user changes from FilterType to FilterType
                            value.scrollTo(viewModel.selectedItem.title, anchor: anchor)
                        }
                    }
                }
            }
            .frame(height: 34.0)
            .background(Color.gray.opacity(0.15))
        }
        .frame(maxHeight: 72.0)
    }

    private func isSelected(_ item: Selectable) -> Bool {
        return viewModel.selectedItem.title == item.title
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ResultsViewModel(for: NewsResult.example)
        let coordinator = ResultsCoordinator(viewModel: viewModel)

        return FilterView(viewModel: viewModel, coordinator: coordinator)
    }
}

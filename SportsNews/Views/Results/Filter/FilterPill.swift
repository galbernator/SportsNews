//
//  FilterPill.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/14/20.
//

import SwiftUI

struct FilterPill: View {
    var item: Selectable
    var isSelected: Bool

    var body: some View {
        Text(item.title)
            .fontWeight(.semibold)
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(isSelected ? Color.white : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
}

struct FilterPill_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FilterPill(item: Sport.nba, isSelected: true)
        }
        .background(Color.gray.opacity(0.2))
    }
}

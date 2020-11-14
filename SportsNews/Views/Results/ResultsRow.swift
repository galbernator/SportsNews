//
//  ResultsRow.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

struct ResultsRow: View {
    let result: Headlineable

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: result.sport.iconName)
                .foregroundColor(Color(result.sport.iconColor))
                .font(.largeTitle)
                .frame(width: 54, height: 54)

            Text(result.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 10)

        }
        .padding(.vertical)
    }
}

struct ResultsRow_Previews: PreviewProvider {
    static var previews: some View {
        let example = F1Result.example

        return ResultsRow(result: example)
    }
}

//
//  LazyView.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let builder: () -> Content

    var body: some View {
        builder()
    }
}

struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView {
            Text("This is a test")
        }
    }
}

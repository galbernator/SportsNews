//
//  SportsNewsApp.swift
//  SportsNews
//
//  Created by Steve Galbraith on 11/13/20.
//

import SwiftUI

@main
struct SportsNewsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{ () -> AnyView in 
                let viewModel = HomeViewModel()
                let coordinator = HomeCoordinator(viewModel: viewModel)

                return coordinator.start()
            }
        }
    }
}

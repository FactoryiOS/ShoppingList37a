//
//  RootView.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 22/8/26.
//

import SwiftUI

struct RootView: View {

    @Environment(AppState.self) private var appState
    @AppStorage(AppTheme.storageKey) private var selectedTheme: AppTheme = .system

    var body: some View {
        content
            .preferredColorScheme(selectedTheme.colorScheme)
    }

    @ViewBuilder
    private var content: some View {
        switch appState.root {
        case .welcome:
            WelcomeScreen(onStart: appState.completeWelcome)

        case .main:
            MainView()
        }
    }
}

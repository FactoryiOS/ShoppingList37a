//
//  RootView.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 22/8/26.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AppState.self) private var appState
    
    var body: some View {
        switch appState.root {
        case .welcome:
            WelcomeScreen(onStart: appState.completeWelcome)
            
        case .main:
            ContentView()
        }
    }
}

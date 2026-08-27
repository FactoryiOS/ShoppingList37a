//
//  ShoppingList37aApp.swift
//  ShoppingList37a
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI

@main
struct ShoppingList37aApp: App {
    
    @State private var appState = AppState()
    @State private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environment(router)
        }
    }
}

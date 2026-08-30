import SwiftUI
import SwiftData

@main
struct ShoppingList37aApp: App {
    @State private var appState = AppState()
    @State private var router = Router()
    @AppStorage("selected_app_theme") private var selectedTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environment(router)
                .preferredColorScheme(selectedTheme.colorScheme)
        }
        .modelContainer(for: [SDShoppingList.self, SDShoppingItem.self])
    }
}

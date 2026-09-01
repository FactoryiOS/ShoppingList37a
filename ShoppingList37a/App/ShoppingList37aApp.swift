import SwiftUI
import SwiftData

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
        .modelContainer(for: [SDShoppingList.self, SDShoppingItem.self])
    }
}

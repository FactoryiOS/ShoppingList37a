import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SDShoppingList.title) private var sdList: [SDShoppingList]
    @State private var repository: Repository?
    @State private var activeList: SDShoppingList?
    
    @Environment(Router.self) private var router
    @AppStorage("selected_app_theme") private var selectedTheme: AppTheme = .system
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.navigationPath) {
            ListsView(observed: .init(lists: sdList.map { ListItem(from: $0)}))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .createList:
                        CreateListView(observed: .init(mode: .create)) { title, color, icon in
                            repository?.createList(
                                title: title,
                                icon: icon,
                                color: color
                            )
                        }
                        
                    case .editList(let list):
                        CreateListView(
                            observed: .init(
                                mode: .edit,
                                listName: list.title,
                                selectedColor: list.color,
                                selectedIcon: list.icon
                            )) { title, color, icon in
                                if let sdList = sdList.first(where: { $0.id == list.id }) {
                                    repository?.updateList(
                                        sdList,
                                        title: title,
                                        icon: icon,
                                        color: color
                                    )
                                }
                            }
                        
                    case .shoppingList(let list):
                        if let shoppingListItem = sdList.first(where: { $0.id == list.id }) {
                            ShoppingListView(
                                observed: .init(
                                    listTitle: shoppingListItem.title, items: shoppingListItem.items.map { ShoppingItem(from: $0)}
                                ),
                                onAdd: {
                                    activeList = shoppingListItem
                                    router.showModal(.createItem)
                                },
                                onEdit: { item in
                                    activeList = shoppingListItem
                                    router.showModal(.editItem(item))
                                },
                                onDelete: { item in
                                    repository?.deleteItem(with: item.id, from: shoppingListItem)
                                },
                                onToggleBought: { item in
                                    repository?.toggleBought(with: item.id, from: shoppingListItem)
                                },
                                onBack: {
                                    router.pop()
                                }
                            )
                        }
                    }
                }
        }
        .sheet(item: $router.presentedModal) { modal in
            switch modal {
            case .createItem:
                ItemEditView(
                    observed: .init(
                        mode: .create,
                        existingNames: existingItemNames(in: activeList)
                    ),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    onDone: { name, quantity, unit in
                        if let activeList {
                            repository?.addItem(
                                to: activeList,
                                name: name,
                                quantity: quantity,
                                unit: unit
                            )
                        }
                        router.presentedModal = nil
                    }
                )
                
            case .editItem(let item):
                ItemEditView(
                    observed: .init(
                        mode: .edit,
                        name: item.name,
                        quantity: String(item.quantity),
                        unit: item.unit,
                        existingNames: existingItemNames(in: activeList, excluding: item.id)
                    ),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    onDone: { name, quantity, unit in
                        if let activeList {
                            repository?.updateItem(
                                with: item.id,
                                in: activeList,
                                name: name,
                                quantity: quantity,
                                unit: unit
                            )
                        }
                        router.presentedModal = nil
                    }
                )
            }
        }
        .preferredColorScheme(selectedTheme.colorScheme)
        .task {
            if repository == nil {
                repository = Repository(context: context)
            }
        }
    }
    
    private func existingItemNames(
        in list: SDShoppingList?,
        excluding id: UUID? = nil
    ) -> Set<String> {
        Set(
            (list?.items ?? [])
                .filter { $0.id != id }
                .map { $0.name }
        )
    }
}

#Preview {
    ContentView()
        .environment(Router())
}

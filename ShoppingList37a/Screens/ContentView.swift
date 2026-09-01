import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SDShoppingList.title) private var sdList: [SDShoppingList]
    @State private var repository: Repository?
    @State private var activeList: SDShoppingList?
    @State private var shareText: String = ""
    @State private var isSharePresented = false
    @State private var pendingDeletion: DeleteConfirmation?
    
    @Environment(Router.self) private var router
    @AppStorage("selected_app_theme") private var selectedTheme: AppTheme = .system
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.navigationPath) {
            ListsView(observed: .init(lists: sdList.map { ListItem(from: $0)}),
                      onDelete: { item in
                pendingDeletion = .deleteList(item)
            })
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .createList:
                        CreateListView(observed: .init(mode: .create)) { title, color, icon in
                            repository?.createList(title: title, icon: icon, color: color)
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
                                    repository?.updateList(sdList, title: title, icon: icon, color: color)
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
                                    activeList = shoppingListItem
                                    pendingDeletion = .deleteItem(item)
                                },
                                
                                onToggleBought: { item in
                                    repository?.toggleBought(with: item.id, from: shoppingListItem)
                                },
                                
                                onBack: {
                                    router.pop()
                                },
                                
                                onMenuAction: { action in
                                    switch action {
                                    case .sort:
                                        break
                                    case .share:
                                        shareText = shoppingListItem.items
                                            .map {
                                                "\($0.name) \($0.quantity) \($0.isBought)/\($0.unit.title)"
                                            }
                                            .joined(separator: "\n")
                                        isSharePresented = true
                                    case .uncheck:
                                        activeList = shoppingListItem
                                        repository?.uncheckItems(in: shoppingListItem)
                                    case .deleteItems:
                                        activeList = shoppingListItem
                                        pendingDeletion = .deleteBoughtItems
                                    }
                                }
                            )
                            .onAppear {
                                activeList = shoppingListItem
                            }
                        }
                    }
                }
        }
        .sheet(isPresented: $isSharePresented) {
            ActivityView(items: [shareText])
        }
        
        .sheet(item: $router.presentedModal) { modal in
            switch modal {
            case .createItem:
                ItemEditView(
                    observed: .init(
                        mode: .create,
                        existingNames: existingItemNames(in: activeList)),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    
                    onDone: { name, quantity, unit in
                        if let activeList { repository?.addItem(
                            to: activeList,
                            name: name,
                            quantity: quantity,
                            unit: unit)}
                        router.presentedModal = nil
                    }
                )
                
            case .editItem(let item):
                ItemEditView(
                    observed: .init(
                        mode: .edit,
                        name: item.name,
                        quantity: String(item.quantity),
                        unit: item.unit.title,
                        existingNames: existingItemNames(in: activeList, excluding: item.id)
                    ),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    
                    onDone: { name, quantity, unit in
                        if let activeList {
                            repository?.updateItem(with: item.id, in: activeList, name: name, quantity: quantity, unit: unit)
                        }
                        router.presentedModal = nil
                    }
                )
            }
        }
        .alert(
            pendingDeletion.map { Text($0.title) } ?? Text(""),
            isPresented: Binding(
                get: { pendingDeletion != nil },
                set: { if !$0 { pendingDeletion = nil } }
            ),
            presenting: pendingDeletion
        ) { confirmation in
            Button("Отменить", role: .cancel) {}
            Button("Удалить", role: .destructive) {
                handleDeletingConfirmation(confirmation)
            }
        } message: { confirmation in
            Text(confirmation.message)
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
    
    private func handleDeletingConfirmation(_ confirmation: DeleteConfirmation) {
        switch confirmation {
        case .deleteList(let listItem):
            if let sdList = sdList.first(where: { $0.id == listItem.id }) {
                repository?.deleteList(sdList)
            }
        case .deleteBoughtItems:
            if let activeList {
                repository?.deleteBoughtItems(in: activeList)
            }
        case .deleteItem(let shoppingItem):
            if let activeList {
                repository?.deleteItem(with: shoppingItem.id, from: activeList)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(Router())
}

import SwiftUI
import SwiftData

private struct ShareItem: Identifiable {
    let id = UUID()
    let text: String
}

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Environment(Router.self) private var router
    @Query(sort: \SDShoppingList.createdAt) private var sdList: [SDShoppingList]

    @State private var repository: Repository?
    @State private var shareItem: ShareItem?
    @State private var pendingDeletion: DeleteConfirmation?

    private var activeList: SDShoppingList? {
        guard case .shoppingList(let item)? = router.navigationPath.last else { return nil }
        return sdList.first { $0.id == item.id }
    }

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.navigationPath) {
            listsView
                .navigationDestination(for: Route.self) { destination(for: $0) }
        }
        .sheet(item: $shareItem) { item in
            ActivityView(items: [item.text])
        }
        .sheet(item: $router.presentedModal) { modal(for: $0) }
        .alert(
            pendingDeletion.map { Text($0.title) } ?? Text(verbatim: ""),
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
        .task {
            if repository == nil {
                repository = Repository(context: context)
            }
        }
    }

    private var listsView: some View {
        ListsView(
            observed: .init(lists: sdList.map { ListItem(from: $0) }),
            onDuplicate: { item in
                guard let sdShoppingList = sdList.first(where: { $0.id == item.id }) else { return }
                repository?.duplicateList(sdShoppingList)
            },
            onDelete: { pendingDeletion = .deleteList($0) }
        )
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
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
                )
            ) { title, color, icon in
                guard let sdShoppingList = sdList.first(where: { $0.id == list.id }) else { return }
                repository?.updateList(sdShoppingList, title: title, icon: icon, color: color)
            }

        case .shoppingList(let list):
            shoppingList(list)
        }
    }

    @ViewBuilder
    private func shoppingList(_ list: ListItem) -> some View {
        if let sdShoppingList = sdList.first(where: { $0.id == list.id }) {
            ShoppingListView(
                listTitle: sdShoppingList.title,
                items: sdShoppingList.items.map { ShoppingItem(from: $0) },
                onAdd: { router.showModal(.createItem) },
                onEdit: { router.showModal(.editItem($0)) },
                onDelete: { pendingDeletion = .deleteItem($0) },
                onToggleBought: { repository?.toggleBought(with: $0.id, from: sdShoppingList) },
                onBack: { router.pop() },
                onMenuAction: { handleMenuAction($0, in: sdShoppingList) }
            )
        }
    }

    private func handleMenuAction(_ action: MenuAction, in list: SDShoppingList) {
        switch action {
        case .sort:
            break
        case .share:
            shareItem = ShareItem(text: list.shareText)
        case .uncheck:
            repository?.uncheckItems(in: list)
        case .deleteItems:
            pendingDeletion = .deleteBoughtItems
        }
    }

    @ViewBuilder
    private func modal(for modal: Modal) -> some View {
        switch modal {
        case .createItem:
            ItemEditView(
                observed: .init(
                    mode: .create,
                    existingNames: existingItemNames(in: activeList),
                    suggestionNames: allItemNames()
                ),
                onCancel: { router.presentedModal = nil },
                onDone: { name, quantity, unit in
                    if let activeList {
                        repository?.addItem(to: activeList, name: name, quantity: quantity, unit: unit)
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
                    existingNames: existingItemNames(in: activeList, excluding: item.id),
                    suggestionNames: allItemNames(excluding: item.id)
                ),
                onCancel: { router.presentedModal = nil },
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

    private func allItemNames(excluding id: UUID? = nil) -> [String] {
        sdList
            .flatMap(\.items)
            .filter { $0.id != id }
            .map(\.name)
    }

    private func existingItemNames(in list: SDShoppingList?, excluding id: UUID? = nil) -> Set<String> {
        Set(
            (list?.items ?? [])
                .filter { $0.id != id }
                .map(\.name)
        )
    }

    private func handleDeletingConfirmation(_ confirmation: DeleteConfirmation) {
        switch confirmation {
        case .deleteList(let listItem):
            guard let sdShoppingList = sdList.first(where: { $0.id == listItem.id }) else { return }
            repository?.deleteList(sdShoppingList)
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

#if DEBUG
#Preview {
    MainView()
        .environment(Router())
}
#endif

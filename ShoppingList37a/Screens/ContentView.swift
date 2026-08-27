//
//  ContentView.swift
//  ShoppingList37a
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.navigationPath) {
            ListsView(observed: .init(lists: ListItem.mocks))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .createList:
                        CreateListView(
                            observed: .init(mode: .create)
                        )
                        
                    case .editList(let list):
                        CreateListView(
                            observed: .init(
                                mode: .edit,
                                listName: list.title,
                                selectedColor: list.color,
                                selectedIcon: list.icon
                            )
                        )
                        
                    case .shoppingList(let list):
                        ShoppingListView(
                            observed: .init(
                                listTitle: list.title
                            ),
                            onAdd: {
                                router.showModal(.createItem)
                            },
                            onEdit: { item in
                                router.showModal(.editItem(item))
                            },
                            onBack: {
                                router.pop()
                            }
                        )
                    }
                }
        }
        .sheet(item: $router.presentedModal) { modal in
            switch modal {
            case .createItem:
                ItemEditView(
                    observed: .init(mode: .create),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    onDone: {
                        router.presentedModal = nil
                    }
                )
                
            case .editItem(let item):
                ItemEditView(
                    observed: .init(
                        mode: .edit,
                        name: item.name,
                        quantity: String(item.quantity),
                        unit: item.unit.title
                    ),
                    onCancel: {
                        router.presentedModal = nil
                    },
                    onDone: {
                        router.presentedModal = nil
                    }
                )
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(Router())
}

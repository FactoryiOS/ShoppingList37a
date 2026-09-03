//
//  Router.swift
//  ShoppingList37a
//
//  Created by Maria Reshetnikova on 27/08/2026.
//

import Observation

enum Route: Hashable {
    case createList
    case editList(ListItem)
    case shoppingList(ListItem)
}

enum Modal: Identifiable {
    case createItem
    case editItem(ShoppingItem)
    
    var id: String {
        switch self {
        case .createItem:
            "createItem"
        case .editItem(let item):
            "editItem-\(item.id)"
        }
    }
}

@Observable
@MainActor
final class Router {
    var navigationPath: [Route] = []
    var presentedModal: Modal?
    
    func push(_ route: Route) {
        navigationPath.append(route)
    }
    
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func showModal(_ modal: Modal) {
        presentedModal = modal
    }
}

//
//  ShoppingListView+Observed.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 25.08.2026.
//

import SwiftUI

extension ShoppingListView {

    @MainActor
    @Observable
    final class Observed {
        let listTitle: String
        var items: [ShoppingItem]
        var searchText: String
        var isSortedAlphabetically = false

        var filteredItems: [ShoppingItem] {
            let query = searchText.trimmingCharacters(in: .whitespaces)
            let base = query.isEmpty
                ? items
                : items.filter { $0.name.localizedCaseInsensitiveContains(query) }
            guard isSortedAlphabetically else { return base }
            return base.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        }

        init(
            listTitle: String,
            items: [ShoppingItem] = [],
            searchText: String = ""
        ) {
            self.listTitle = listTitle
            self.items = items
            self.searchText = searchText
        }

        func toggleBought(_ item: ShoppingItem) {
            guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
            items[index].isBought.toggle()
        }

        func toggleAlphabeticalSort() {
            isSortedAlphabetically.toggle()
        }
    }
}

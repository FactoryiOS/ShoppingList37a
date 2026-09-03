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
        let items: [ShoppingItem]
        var searchText: String

        var filteredItems: [ShoppingItem] {
            let query = searchText.trimmingCharacters(in: .whitespaces)
            guard !query.isEmpty else { return items }
            return items.filter { $0.name.localizedCaseInsensitiveContains(query) }
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
    }
}

//
//  ShoppingListView+Observed.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 25.08.2026.
//
import SwiftUI

extension ShoppingListView {

    /// Логика экрана списка товаров.
    @MainActor
    @Observable
    final class Observed {
        let listTitle: String
        var items: [ShoppingItem]
        var searchText: String

        /// Товары, отфильтрованные по строке поиска.
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

        /// Переключает отметку о покупке у товара.
        func toggleBought(_ item: ShoppingItem) {
            guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
            items[index].isBought.toggle()
        }
        
        func sortAlphabetically() {
            items.sort { $0.name.localizedCompare($1.name) == .orderedAscending }
        }
    }
}

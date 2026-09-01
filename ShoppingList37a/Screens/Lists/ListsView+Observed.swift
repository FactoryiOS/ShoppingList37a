//
//  ListsView+Observed.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 23/8/26.
//

import SwiftUI

extension ListsView {

    /// Источник данных - моки, позже заменятся на запросы к SwiftData
    @MainActor
    @Observable
    final class Observed {
        var lists: [ListItem]

        init(lists: [ListItem]) {
            self.lists = lists
        }
        
        func sortAlphabetically() {
            lists.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
        }
    }
}

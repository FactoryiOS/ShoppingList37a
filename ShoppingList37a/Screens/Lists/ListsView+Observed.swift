//
//  ListsView+Observed.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 23/8/26.
//

import SwiftUI

extension ListsView {

    @MainActor
    @Observable
    final class Observed {
        let lists: [ListItem]

        init(lists: [ListItem]) {
            self.lists = lists
        }
    }
}

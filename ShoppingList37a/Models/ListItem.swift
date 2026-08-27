//
//  ListItem.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 19/8/26.
//

import Foundation

struct ListItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let icon: SelectableIcon
    let color: SelectableColor
    let boughtCount: Int
    let totalCount: Int
}

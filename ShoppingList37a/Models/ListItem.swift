//
//  ListItem.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 19/8/26.
//

import Foundation

struct ListItem: Identifiable {
    let id: UUID
    let title: String
    let icon: SelectableIcon
    let color: SelectableColor
    let boughtCount: Int
    let totalCount: Int
}

extension ListItem {
    init(from sdList: SDShoppingList) {
        self.init(
            id: sdList.id,
            title: sdList.title,
            icon: sdList.icon,
            color: sdList.color,
            boughtCount: sdList.boughtCount,
            totalCount: sdList.totalCount)
    }
}

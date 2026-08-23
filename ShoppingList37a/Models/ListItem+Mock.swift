//
//  ListItem+Mock.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 19/8/26.
//

import Foundation

extension ListItem {
    static let mock = ListItem(
        id: UUID(),
        title: "Новый год",
        icon: .calendar,
        color: .blue,
        boughtCount: 10,
        totalCount: 20
    )
}

//
//  ListItem+Mock.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 19/8/26.
//

import Foundation

extension ListItem {
    static let mocks: [ListItem] = [
        ListItem(
            id: UUID(),
            title: "Новый год",
            icon: .calendar,
            color: .blue,
            boughtCount: 10,
            totalCount: 20
        ),
        ListItem(
            id: UUID(),
            title: "Кошке",
            icon: .paw,
            color: .green,
            boughtCount: 1,
            totalCount: 4
        ),
        ListItem(
            id: UUID(),
            title: "Вечеринка малого",
            icon: .controller,
            color: .yellow,
            boughtCount: 9,
            totalCount: 20
        )
    ]

    static let mock = mocks[0]
}

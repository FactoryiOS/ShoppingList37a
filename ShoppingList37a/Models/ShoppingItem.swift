//
//  ShoppingItem.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 20/08/2026.
//

import Foundation

struct ShoppingItem: Identifiable {
    let id: UUID
    let name: String
    let quantity: Int
    let unit: ShoppingItemUnit
    var isBought: Bool

    init(
        id: UUID = UUID(),
        name: String,
        quantity: Int,
        unit: ShoppingItemUnit = .pieces,
        isBought: Bool = false
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.isBought = isBought
    }
}

extension ShoppingItem {
    init(from sdItem: SDShoppingItem) {
        self.init(
            id: sdItem.id,
            name: sdItem.name,
            quantity: sdItem.quantity,
            unit: sdItem.unit,
            isBought: sdItem.isBought
        )
    }
}

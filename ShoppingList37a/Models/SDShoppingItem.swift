//
//  SDShoppingItem.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 28.08.2026.
//

import SwiftUI
import SwiftData

@Model
final class SDShoppingItem {
    var id: UUID
    var name: String
    var quantity: Int
    var unitRawValue: String
    var isBought: Bool
    var list: SDShoppingList?

    init(
        id: UUID = UUID(),
        name: String,
        quantity: Int,
        unit: ShoppingItemUnit
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unitRawValue = unit.rawValue
        self.isBought = false
    }

    var unit: ShoppingItemUnit {
        get { ShoppingItemUnit(rawValue: unitRawValue) ?? .pieces }
        set { unitRawValue = newValue.rawValue }
    }
}

//
//  SwiftDataModel.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 28.08.2026.
//
import SwiftUI
import SwiftData

@Model
final class SDShoppingList {
    var id: UUID
    var title: String
    var iconRawValue: String
    var colorRawValue: String
    var boughtCount: Int { items.filter(\.isBought).count }
    var totalCount: Int { items.count }
    
    @Relationship(deleteRule: .cascade, inverse: \SDShoppingItem.list)
    var items: [SDShoppingItem] = []

    init(id: UUID = UUID(), title: String, icon: SelectableIcon, color: SelectableColor) {
        self.id = id
        self.title = title
        self.iconRawValue = icon.rawValue
        self.colorRawValue = color.rawValue
    }
    
    var icon: SelectableIcon {
        get { SelectableIcon(rawValue: iconRawValue) ?? .snow }
        set { iconRawValue = newValue.rawValue }
    }
    
    var color: SelectableColor {
        get { SelectableColor(rawValue: colorRawValue) ?? .blue }
        set { colorRawValue = newValue.rawValue }
    }
}

@Model
final class SDShoppingItem {
    var id: UUID
    var name: String
    var quantity: Int
    var unitRawValue: String
    var isBought: Bool
    var list: SDShoppingList?
    
    init(id: UUID = UUID(), name: String, quantity: Int, unit: ShoppingItemUnit) {
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

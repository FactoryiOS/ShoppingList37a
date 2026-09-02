//
//  Repository.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 28.08.2026.
//

import Foundation
import SwiftData

@Observable
final class Repository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func createList(
        title: String,
        icon: SelectableIcon,
        color: SelectableColor
    ) {
        let list = SDShoppingList(title: title, icon: icon, color: color)
        context.insert(list)
        save()
    }
    
    func updateList(
        _ list: SDShoppingList,
        title: String,
        icon: SelectableIcon,
        color: SelectableColor
    ) {
        list.title = title
        list.icon = icon
        list.color = color
        save()
    }
    
    func duplicateList(_ list: SDShoppingList) {
        let copy = SDShoppingList(
            title: copyTitle(for: list.title),
            icon: list.icon,
            color: list.color
        )
        copy.items = list.items.map {
            SDShoppingItem(name: $0.name, quantity: $0.quantity, unit: $0.unit)
        }
        context.insert(copy)
        save()
    }
    
    func deleteList(_ list: SDShoppingList) {
        context.delete(list)
        save()
    }

    func addItem(
        to shoppingList: SDShoppingList,
        name: String,
        quantity: Int,
        unit: ShoppingItemUnit
    ) {
        let item = SDShoppingItem(name: name, quantity: quantity, unit: unit)
        item.list = shoppingList
        context.insert(item)
        save()
    }
    
    func updateItem(
        _ item: SDShoppingItem,
        name: String,
        quantity: Int,
        unit: ShoppingItemUnit
    ) {
        item.name = name
        item.quantity = quantity
        item.unit = unit
        save()
    }
    
    func uncheckItems(in list: SDShoppingList) {
        list.items.forEach { $0.isBought = false }
        save()
    }

    func updateItem(
        with id: UUID,
        in list: SDShoppingList,
        name: String,
        quantity: Int,
        unit: ShoppingItemUnit
    ) {
        guard let item = list.items.first(where: { $0.id == id }) else { return }
        updateItem(item, name: name, quantity: quantity, unit: unit)
    }
    
    func deleteBoughtItems(in list: SDShoppingList) {
        list.items.filter(\.isBought).forEach { context.delete($0) }
        save()
    }
    
    func deleteItem(_ item: SDShoppingItem) {
        context.delete(item)
        save()
    }
    
    func deleteItem(with id: UUID, from list: SDShoppingList) {
        guard let item = list.items.first(where: { $0.id == id }) else { return }
        deleteItem(item)
    }
    
    func toggleBought(_ item: SDShoppingItem) {
        item.isBought.toggle()
        save()
    }
    
    func toggleBought(with id: UUID, from list: SDShoppingList) {
        guard let item = list.items.first(where: { $0.id == id }) else { return }
        toggleBought(item)
    }
    
    private func copyTitle(for title: String) -> String {
        let suffix = String(localized: "копия")
        let base = strippingCopySuffix(from: title, suffix: suffix)
        let existing = existingTitles()

        var candidate = "\(base) \(suffix)"
        var index = 1
        while existing.contains(candidate) {
            index += 1
            candidate = "\(base) \(suffix) \(index)"
        }
        return candidate
    }

    private func strippingCopySuffix(from title: String, suffix: String) -> String {
        let escaped = NSRegularExpression.escapedPattern(for: suffix)
        guard let regex = try? Regex("\\s+\(escaped)(\\s+\\d+)?$") else {
            return title
        }
        let base = title.replacing(regex, with: "")
        return base.isEmpty ? title : base
    }

    private func existingTitles() -> Set<String> {
        let descriptor = FetchDescriptor<SDShoppingList>()
        let lists = (try? context.fetch(descriptor)) ?? []
        return Set(lists.map(\.title))
    }

    private func save() {
        do {
            try context.save()
        } catch {
            print(DataError.saveFailed(error))
        }
    }
}

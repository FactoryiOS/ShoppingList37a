//
//  DeleteConfirmation.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import Foundation

enum DeleteConfirmation: Identifiable {
    case deleteList(ListItem)
    case deleteBoughtItems
    case deleteItem(ShoppingItem)
    
    var id: String {
        switch self {
        case .deleteList(let listItem):
            "\(listItem)"
        case .deleteBoughtItems:
            "Bought"
        case .deleteItem(let shoppingItem):
            "\(shoppingItem)"
        }
    }
    
    var title: String {
        switch self {
        case .deleteList(let listItem):
            "Удаление списка"
        case .deleteBoughtItems:
            "Удаление купленных товаров"
        case .deleteItem(let shoppingItem):
            "Удаление товара"
        }
    }
    
    var message: String {
        switch self {
        case .deleteList(let listItem):
            "Вы действительно хотите удалить список?"
        case .deleteBoughtItems:
            "Вы действительно хотите удалить все купленные товары?"
        case .deleteItem(let shoppingItem):
            "Вы действительно хотите удалить товар?"
        }
    }
}

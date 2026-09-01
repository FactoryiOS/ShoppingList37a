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
        case .deleteList:
            "deleteList"
        case .deleteBoughtItems:
            "deleteBoughtItems"
        case .deleteItem:
            "deleteShoppingItems"
        }
    }
    
    var title: LocalizedStringResource {
        switch self {
        case .deleteList:
            "Удаление списка"
        case .deleteBoughtItems:
            "Удаление купленных товаров"
        case .deleteItem:
            "Удаление товара"
        }
    }
    
    var message: LocalizedStringResource {
        switch self {
        case .deleteList:
            "Вы действительно хотите удалить список?"
        case .deleteBoughtItems:
            "Вы действительно хотите удалить все купленные товары?"
        case .deleteItem:
            "Вы действительно хотите удалить товар?"
        }
    }
}

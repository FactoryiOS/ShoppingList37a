//
//  ShoppingItemUnit.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 20/08/2026.
//

import Foundation

enum ShoppingItemUnit: String {
    case pieces
    case kilograms
    case grams
    case liters
    case milliliters

    var title: String {
        switch self {
        case .pieces: "шт."
        case .kilograms: "кг."
        case .grams: "г."
        case .liters: "л."
        case .milliliters: "мл."
        }
    }
}

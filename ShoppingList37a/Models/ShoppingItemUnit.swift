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
extension ShoppingItemUnit {
    init?(input: String) {
        switch input.lowercased().trimmingCharacters(in: .whitespaces) {
        case "шт", "шт.": self = .pieces
        case "кг", "кг.": self = .kilograms
        case "г", "г.": self = .grams
        case "л", "л.": self = .liters
        case "мл", "мл.": self = .milliliters
        default: return nil
        }
    }
}

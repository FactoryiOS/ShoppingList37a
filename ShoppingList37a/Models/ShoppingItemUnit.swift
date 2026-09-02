//
//  ShoppingItemUnit.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 20/08/2026.
//

import SwiftUI

enum ShoppingItemUnit: String, CaseIterable {
    case pieces
    case kilograms
    case grams
    case liters
    case milliliters

    var title: LocalizedStringKey {
        switch self {
        case .pieces: "шт."
        case .kilograms: "кг."
        case .grams: "г."
        case .liters: "л."
        case .milliliters: "мл."
        }
    }

    var shortName: String {
        switch self {
        case .pieces: "шт."
        case .kilograms: "кг."
        case .grams: "г."
        case .liters: "л."
        case .milliliters: "мл."
        }
    }
}

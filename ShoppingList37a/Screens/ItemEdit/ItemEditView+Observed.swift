//
//  ItemEditView+Observed.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 20.08.2026.
//
import SwiftUI

extension ItemEditView {

    /// Состояние экрана: создание нового товара или редактирование существующего.
    enum Mode {
        case create
        case edit

        var title: LocalizedStringKey {
            switch self {
            case .create: "Создание товара"
            case .edit: "Редактировать"
            }
        }
    }

    /// Логика экрана создания/редактирования товара.
    @MainActor
    @Observable
    final class Observed {
        let mode: Mode
        var name: String
        var quantity: String
        var unit: ShoppingItemUnit

        var isDoneEnabled: Bool {
            !name.isEmpty && !quantity.isEmpty
        }

        init(
            mode: Mode = .create,
            name: String = "",
            quantity: String = "",
            unit: ShoppingItemUnit = .pieces
        ) {
            self.mode = mode
            self.name = name
            self.quantity = quantity
            self.unit = unit
        }
    }
}

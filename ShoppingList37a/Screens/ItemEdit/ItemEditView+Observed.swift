//
//  ItemEditView+Observed.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 20.08.2026.
//
import SwiftUI

private enum Constants {
    static let maxSuggestions = 3
}

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

        let existingNames: Set<String>
        let suggestionNames: [String]

        private static func normalized(_ string: String) -> String {
            string.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        }

        private var normalizedName: String {
            Self.normalized(name)
        }

        var isNameDuplicate: Bool {
            !normalizedName.isEmpty && existingNames.contains(normalizedName)
        }

        var nameError: LocalizedStringKey? {
            isNameDuplicate ? Errors.itemAlreadyExists : nil
        }

        var isDoneEnabled: Bool {
            !name.isEmpty && !quantity.isEmpty && !isNameDuplicate
        }

        /// Подсказки названий по введённому префиксу — без точного совпадения и товаров текущего списка.
        var suggestions: [String] {
            let query = normalizedName
            guard !query.isEmpty else { return [] }

            var seenNames = Set<String>()
            let matches = suggestionNames.filter { name in
                let normalized = Self.normalized(name)
                return normalized.hasPrefix(query)
                    && normalized != query
                    && !existingNames.contains(normalized)
                    && seenNames.insert(normalized).inserted
            }

            return Array(
                matches
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
                    .prefix(Constants.maxSuggestions)
            )
        }

        init(
            mode: Mode = .create,
            name: String = "",
            quantity: String = "",
            unit: ShoppingItemUnit = .pieces,
            existingNames: Set<String> = [],
            suggestionNames: [String] = []
        ) {
            self.mode = mode
            self.name = name
            self.quantity = quantity
            self.unit = unit
            self.existingNames = Set(existingNames.map(Self.normalized))
            self.suggestionNames = suggestionNames
        }
    }
}

//
//  ActionMenuView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import SwiftUI

enum MenuAction: CaseIterable {
    case sort
    case share
    case uncheck
    case deleteItems

    var title: LocalizedStringKey {
        switch self {
        case .sort: "Сортировать по Алфавиту"
        case .share: "Поделиться"
        case .uncheck: "Снять отметки со всех товаров"
        case .deleteItems: "Удалить купленные товары"
        }
    }

    var icon: String {
        switch self {
        case .sort: "arrow.up.arrow.down"
        case .share: "square.and.arrow.up"
        case .uncheck: "arrow.triangle.2.circlepath"
        case .deleteItems: "trash"
        }
    }
    
    var isDestructive: Bool {
        self == .deleteItems
    }
}

struct ActionMenuView: View {

    let onAction: (MenuAction) -> Void
    var isSortActive: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            menu
        }
        .frame(width: 250)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        .transition(.opacity.combined(with: .scale(scale: 0.98, anchor: .topTrailing)))
    }

    private var menu: some View {
        VStack(spacing: 0) {
            ForEach(MenuAction.allCases, id: \.self) { action in
                MenuActionViewRow(
                    title: action.title,
                    icon: action.icon,
                    isDestructive: action.isDestructive,
                    isSelected: action == .sort && isSortActive,
                    action: { onAction(action) }
                )
                if action != MenuAction.allCases.last {
                    Divider()
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    ActionMenuView(onAction: {_ in })
}
#endif

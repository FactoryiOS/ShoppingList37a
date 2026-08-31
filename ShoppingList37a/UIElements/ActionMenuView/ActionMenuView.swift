//
//  ActionMenuView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import SwiftUI

enum MenuAction: String, CaseIterable {
    case sort = "Сортировка по Алфавиту"
    case share = "Поделиться"
    case uncheck = "Снять отметки со всех товаров"
    case deleteItems = "Удалить купленные товары"
    
    var title: String { rawValue }
    
    var icon: String {
        switch self {
        case .sort: "arrow.up.arrow.down"
        case .share: "square.and.arrow.up"
        case .uncheck: "arrow.trianglehead.2.clockwise.rotate.90"
        case .deleteItems: "trash"
        }
    }
    
    var isDestractive: Bool {
        self == .deleteItems
    }
}

struct ActionMenuView: View {
    
    let onAction: (MenuAction) -> Void
    var body: some View {
        VStack(spacing: 0) {
            menu
        }
        .frame(width: 250)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .topTrailing)))
    }
    
    private var menu: some View {
        VStack(spacing: 0) {
            ForEach(MenuAction.allCases, id: \.self) { action in
                MenuActionViewRow(
                    title: action.title,
                    icon: action.icon,
                    isDestractive: action.isDestractive,
                    action: { onAction(action) }
                )
                if action != MenuAction.allCases.last {
                    Divider()
                }
            }
        }
    }
    
//    private func handle(_ action: MenuAction) {
//        switch action {
//        case .sort:
//        case .share:
//        case .uncheck:
//        case .deleteItems:
//        }
//    }
}

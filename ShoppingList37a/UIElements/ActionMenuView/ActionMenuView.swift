//
//  ActionMenuView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 0
    static let frameWidth: CGFloat = 250
    static let cornerRadius: CGFloat = 12
    static let opacity = 0.12
    static let shadowRadius: CGFloat = 8
    static let xArg: CGFloat = 0
    static let yArg: CGFloat = 4
    static let shadowScale = 0.98
}

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
    
    var isDestractive: Bool {
        self == .deleteItems
    }
}

struct ActionMenuView: View {

    let onAction: (MenuAction) -> Void
    var isSortActive: Bool = false

    var body: some View {
        VStack(spacing: Constants.spacing) {
            menu
        }
        .frame(width: Constants.frameWidth)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .shadow(color: Color.black.opacity(Constants.opacity), radius: Constants.shadowRadius, x: Constants.xArg, y: Constants.yArg)
        .transition(.opacity.combined(with: .scale(scale: Constants.shadowScale, anchor: .topTrailing)))
    }
    
    private var menu: some View {
        VStack(spacing: Constants.spacing) {
            ForEach(MenuAction.allCases, id: \.self) { action in
                MenuActionViewRow(
                    title: action.title,
                    icon: action.icon,
                    isDestractive: action.isDestractive,
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

#Preview {
    ActionMenuView(onAction: {_ in })
}

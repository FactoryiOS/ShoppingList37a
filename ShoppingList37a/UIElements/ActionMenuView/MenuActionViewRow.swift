//
//  MenuActionViewCell.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import SwiftUI

struct MenuActionViewRow: View {
    var title: LocalizedStringKey
    var icon: String
    var isDestructive: Bool
    var isSelected: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(title)
                    .font(AppFont.bodyRegular)
                    .foregroundStyle(isDestructive ? .slDestructive : .slTextPrimary)
                    .padding(8)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                        .foregroundStyle(.slAccent)
                }

                Spacer()

                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(isDestructive ? .slDestructive : .slTextPrimary)
                    .frame(width: 20)
                    .padding(.trailing, 8)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    MenuActionViewRow(title: "Сортировка по Алфавиту", icon: "arrow.up.arrow.down", isDestructive: false, action: {})
}

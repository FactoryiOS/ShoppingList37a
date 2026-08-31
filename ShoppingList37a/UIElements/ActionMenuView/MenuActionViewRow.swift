//
//  MenuActionViewCell.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 01.09.2026.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 0
    static let padding: CGFloat = 16
    static let iconSize: Font = .system(size: 16)
    static let frameHeight: CGFloat = 52
}

struct MenuActionViewRow: View {
    var title: String
    var icon: String
    var isDestractive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Constants.spacing) {
                Text(title)
                    .font(AppFont.bodyRegular)
                    .foregroundStyle(isDestractive ? .slDestructive : .slTextPrimary)
                    .padding(Constants.padding)
                Image(systemName: icon)
                    .font(Constants.iconSize)
                    .foregroundStyle(isDestractive ? .slDestructive : .slTextPrimary)
                    .padding(.trailing, Constants.padding)
            }
            .frame(height: Constants.frameHeight)
        }
    }
}

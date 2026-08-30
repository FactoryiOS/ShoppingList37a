//
//  ShoppingItemView.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 20/08/2026.
//

import SwiftUI

struct ShoppingItemView: View {

    let item: ShoppingItem

    var body: some View {
        HStack(spacing: 16) {
            checkbox

            Text(item.name)
                .font(AppFont.bodyRegular)
                .foregroundStyle(item.isBought ? .slTextSecondary : .slTextCounter)

            Spacer()

            (Text(verbatim: "\(item.quantity) ") + Text(item.unit.title))
                .font(AppFont.bodyRegular)
                .foregroundStyle(item.isBought ? .slTextSecondary : .slTextCounter)
        }
        .padding(16)
        .background(.slBackgroundPrimary)
    }

    private var checkbox: some View {
        Group {
            if item.isBought {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.slAccent)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.slTextOnAccent)
                    }
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(.slCheckboxBorder, lineWidth: 2)
            }
        }
        .frame(width: 28, height: 28)
    }
}

#Preview {
    ZStack {
        Color.slBackgroundPrimary
            .ignoresSafeArea()

        VStack(spacing: 0) {
            ShoppingItemView(item: .mock)

            Divider()

            ShoppingItemView(
                item: ShoppingItem(name: "Чайник", quantity: 2, isBought: true)
            )
        }
    }
}

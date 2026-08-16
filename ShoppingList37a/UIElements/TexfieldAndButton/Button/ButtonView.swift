//
//  Button.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/16.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    var isActive: Bool
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(isActive ? .white : .slTextSecondary)
                .font(AppFont.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(isActive ? .slAccent : .slButtonDisabled)
                .cornerRadius(100)
        }
        .disabled(!isActive)
    }
}

#Preview {
    ZStack {
        Color.slTextSecondary
        ButtonView(isActive: true, title: "Создать", action: { })
    }
}

//
//  ButtonView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/16.
//
import SwiftUI

struct ButtonView: View {
    var isActive: Bool
    var title: LocalizedStringKey
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

#Preview("light") {
    ZStack {
        Color.slBackgroundPrimary.ignoresSafeArea()
        VStack {
            Spacer()
            ButtonView(isActive: true, title: "Создать", action: { })
        }
        .padding(16)
    }
    .preferredColorScheme(.light)
}

#Preview("dark") {
    ZStack {
        Color.slBackgroundPrimary.ignoresSafeArea()
        VStack {
            Spacer()
            ButtonView(isActive: false, title: "Создать", action: { })
        }
        .padding(16)
    }
    .preferredColorScheme(.dark)
}

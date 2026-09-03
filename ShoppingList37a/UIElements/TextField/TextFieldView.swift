//
//  TextFieldView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/15.
//

import SwiftUI

private enum Constants {
    static let xmark = "xmark.circle.fill"
}

struct TextFieldView: View {
    let placeholder: LocalizedStringKey

    @Binding var text: String
    let isError: Bool
    let errorMessage: LocalizedStringKey?
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                TextField(placeholder, text: $text)
                    
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: Constants.xmark)
                            .foregroundStyle(.slTextSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .font(AppFont.bodyRegular)
            .padding(.horizontal)
            .background(.slBackgroundElevated)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isError ? .slDestructive : .clear, lineWidth: 0.5)
            }
            
            if isError, let errorMessage {
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(AppFont.footnote)
                    .foregroundStyle(.slDestructive)
            }
        }
    }
}

#if DEBUG
#Preview("light") {
    ZStack {
        Color.slBackgroundPrimary.ignoresSafeArea()
        VStack {
            TextFieldView(
                placeholder: "Название списка",
                text: .constant("Список 1"),
                isError: true,
                errorMessage: Errors.duplicateName
            )
            .padding()
            Spacer()
        }
    }
    .preferredColorScheme(.light)
}

#Preview("dark") {
    ZStack {
        Color.slBackgroundPrimary.ignoresSafeArea()
        VStack {
            TextFieldView(
                placeholder: "Название списка",
                text: .constant(""),
                isError: true,
                errorMessage: Errors.duplicateName
            )
            .padding()
            Spacer()
        }
    }
    .preferredColorScheme(.dark)
}
#endif

//
//  TextFieldView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/15.
//
import SwiftUI

private enum Constants {
    static let xmark = "xmark.circle.fill"
    static let spacing: CGFloat = 4
    static let cornerRadius: CGFloat = 12
    static let lineWidth = 0.5
    static let height: CGFloat = 54
}

struct TextFieldView: View {
    let placeholder: LocalizedStringKey

    @Binding var text: String
    let isError: Bool
    let errorMessage: LocalizedStringKey?
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
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
            .frame(height: Constants.height)
            .font(AppFont.bodyRegular)
            .padding(.horizontal)
            .background(.slBackgroundElevated)
            .cornerRadius(Constants.cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(isError ? .slDestructive : .clear, lineWidth: Constants.lineWidth)
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

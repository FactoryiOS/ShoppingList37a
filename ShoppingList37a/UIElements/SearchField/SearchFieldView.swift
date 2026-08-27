//
//  SearchFieldView.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 26.08.2026.
//
import SwiftUI

private enum Constants {
    static let searchIcon = "magnifyingglass"
    static let clearIcon = "xmark.circle.fill"
    static let spacing: CGFloat = 8
    static let cornerRadius: CGFloat = 10
    static let height: CGFloat = 36
}

struct SearchFieldView: View {
    let placeholder: String

    @Binding var text: String

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: Constants.spacing) {
            Image(systemName: Constants.searchIcon)
                .foregroundStyle(.slTextSecondary)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.slTextSecondary)
            )
            .font(AppFont.bodyRegular)
            .foregroundStyle(.slTextPrimary)
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .submitLabel(.search)
            .accessibilityAddTraits(.isSearchField)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: Constants.clearIcon)
                        .foregroundStyle(.slTextSecondary)
                }
            }
        }
        .padding(.horizontal, Constants.spacing)
        .frame(height: Constants.height)
        .background(.slBackgroundElevated)
        .cornerRadius(Constants.cornerRadius)
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
    }
}

#Preview("light") {
    ZStack {
        Color.slBackgroundPrimary.ignoresSafeArea()
        VStack {
            SearchFieldView(placeholder: "Поиск", text: .constant(""))
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
            SearchFieldView(placeholder: "Поиск", text: .constant("Чайник"))
                .padding()
            Spacer()
        }
    }
    .preferredColorScheme(.dark)
}

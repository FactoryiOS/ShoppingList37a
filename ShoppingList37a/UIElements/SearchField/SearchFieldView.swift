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
}

struct SearchFieldView: View {
    let placeholder: LocalizedStringKey

    @Binding var text: String

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: Constants.searchIcon)
                .foregroundStyle(.slTextSecondary)

            TextField(
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.slTextSecondary)
            ) {
                Text(verbatim: "")
            }
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
        .padding(.horizontal, 8)
        .frame(height: 36)
        .background(.slBackgroundElevated)
        .cornerRadius(10)
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
    }
}

#if DEBUG
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
#endif

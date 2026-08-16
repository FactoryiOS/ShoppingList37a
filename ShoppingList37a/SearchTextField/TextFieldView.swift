//
//  TextFieldView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/15.
//

import Foundation
import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    
    @Binding var text: String
    let isError: Bool
    let errorMessage: String?
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                TextField(placeholder, text: $text)
                    
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: SystemIcons.xmarkIcon)
                            .foregroundStyle(Color.slTextSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .font(Font.body)
            .padding(.horizontal)
            .background(Color.slBackgroundElevated)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke( isError ? Color.slDestructive : .clear, lineWidth: 0.5)
            }
            
            if isError, let errorMessage {
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(Font.footnote)
                    .foregroundStyle(Color.slDestructive)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.slIconBackground
        TextFieldView(
            placeholder: "Название списка",
            text: .constant("Список 1"),
            isError: true,
            errorMessage: Errors.duplicateName
        )
        .padding()
    }
}

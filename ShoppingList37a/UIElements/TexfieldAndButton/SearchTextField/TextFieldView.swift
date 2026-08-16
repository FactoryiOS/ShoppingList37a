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
                            .foregroundStyle(.slTextSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .font(AppFont.bodyRegular)
            .padding(.horizontal)
            .background(.slBackgroundElevated)
            .cornerRadius(Metrics.cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .stroke( isError ? .slDestructive : .clear, lineWidth: 0.5)
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

//
//  ColorSelectionView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//

import Foundation
import SwiftUI

struct ColorSelectionView: View {
    
    @Binding var selectedColor: String?
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(AppFont.callout)
                .foregroundStyle(.slTextCounter)
                .padding(.top, 12)
                .padding(.leading, 12)
                .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                ForEach(ColorSet.colors, id: \.self) { option in
                    Button {
                        selectedColor = option.id
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(selectedColor == option.id ? .slAccent : .clear, lineWidth: 2)
                                .frame(width: 48, height: 48)
                            Circle()
                                .fill(option.color)
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 48, height: 48, alignment: .center)
                        .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(.slBackgroundElevated)
        .cornerRadius(12)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selectedColor: String? = nil
        var body: some View {
            ZStack {
                Color.slIconBackground
                ColorSelectionView(selectedColor: $selectedColor, title: "Выберите цвет")
            }
        }
    }
    return PreviewWrapper()
}

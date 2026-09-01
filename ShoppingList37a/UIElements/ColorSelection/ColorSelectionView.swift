//
//  ColorSelectionView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//
import SwiftUI

struct ColorSelectionView: View {
    
    @Binding var selectedColor: SelectableColor?
    var title: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(AppFont.callout)
                .foregroundStyle(.slTextCounter)
                .padding(.top, 12)
                .padding(.leading, 12)
                .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                ForEach(SelectableColor.allCases) { color in
                    Button {
                        selectedColor = color
                    } label: {
                        ColorCell(color: color.color, isSelected: selectedColor == color)
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

#Preview("light") {
    struct PreviewWrapper: View {
        @State var selectedColor: SelectableColor?
        var body: some View {
            ZStack {
                Color.slBackgroundPrimary
                ColorSelectionView(selectedColor: $selectedColor, title: "Выберите цвет")
            }
            .preferredColorScheme(.light)
        }
    }
    return PreviewWrapper()
}

#Preview("dark") {
    struct PreviewWrapper: View {
        @State var selectedColor: SelectableColor?
        var body: some View {
            ZStack {
                Color.slBackgroundPrimary
                ColorSelectionView(selectedColor: $selectedColor, title: "Выберите цвет")
            }
            .preferredColorScheme(.dark)
        }
    }
    return PreviewWrapper()
}

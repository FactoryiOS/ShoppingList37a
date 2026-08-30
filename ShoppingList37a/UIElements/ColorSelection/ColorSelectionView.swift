//
//  ColorSelectionView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//
import SwiftUI

private enum Constants {
    static let spacingZero: CGFloat = 0
    static let padding: CGFloat = 12
    static let spacing: CGFloat = 12
    static let cornerRadius: CGFloat = 12
}

struct ColorSelectionView: View {
    
    @Binding var selectedColor: SelectableColor?
    var title: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacingZero) {
            Text(title)
                .font(AppFont.callout)
                .foregroundStyle(.slTextCounter)
                .padding(.top, Constants.padding)
                .padding(.leading, Constants.padding)
                .padding(.bottom, Constants.padding)
            
            HStack(spacing: Constants.spacing) {
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
            .padding(.horizontal, Constants.padding)
            .padding(.bottom, Constants.padding)
        }
        .background(.slBackgroundElevated)
        .cornerRadius(Constants.cornerRadius)
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

//
//  ColorSelectionView.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//

import Foundation
import SwiftUI

struct ColorSelectionView: View {
    var title: String
    
    let rows = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(Font.callout)
                .foregroundStyle(.slTextCounter)
                .frame(width: .infinity, alignment: .leading)
            
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(ColorSet.colors, id: \.self) { color in
                    Ellipse()
                        .foregroundStyle(color)
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
}

#Preview {
    ColorSelectionView(title: "Выберите цвет")
}

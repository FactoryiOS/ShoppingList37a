//
//  ColorCell.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 17.08.2026.
//

import SwiftUI

struct ColorCell: View {
    
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? .slAccent : .clear, lineWidth: 2)
                .frame(width: 48, height: 48)
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
        }
        .frame(width: 48, height: 48, alignment: .center)
        .contentShape(Circle())
    }
}

#if DEBUG
#Preview {
    ColorCell(color: .slCategoryBlue, isSelected: true)
}
#endif

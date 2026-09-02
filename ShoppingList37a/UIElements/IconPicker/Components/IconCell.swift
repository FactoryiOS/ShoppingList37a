//
//  IconCell.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 16/8/26.
//

import SwiftUI

struct IconCell: View {

    let icon: SelectableIcon
    let isSelected: Bool
    let selectionColor: Color
    
    var body: some View {
        Image(icon.assetName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(Color(.slBackgroundPrimary))
            .padding(12)
            .background(isSelected ? selectionColor : Color(.slIconBackground))
            .clipShape(Circle())
    }
}

#if DEBUG
#Preview() {
    HStack(spacing: 8) {
        IconCell(icon: .snow, isSelected: true, selectionColor: Color(.slCategoryBlue))
        IconCell(icon: .airplane, isSelected: false, selectionColor: Color(.slCategoryBlue))
    }
    .frame(width: 160)
    .padding()
}
#endif

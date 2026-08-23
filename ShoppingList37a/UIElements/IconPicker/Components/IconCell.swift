//
//  IconCell.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 16/8/26.
//

import SwiftUI

struct IconCell: View {
    
    private enum Constants {
        static let iconSize: CGFloat = 24
        static let padding: CGFloat = 12
    }
    
    let icon: SelectableIcon
    let isSelected: Bool
    let selectionColor: Color
    
    var body: some View {
        Image(icon.assetName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: Constants.iconSize, height: Constants.iconSize)
            .foregroundStyle(Color(.slBackgroundPrimary))
            .padding(Constants.padding)
            .background(isSelected ? selectionColor : Color(.slIconBackground))
            .clipShape(Circle())
    }
}

#Preview("Light") {
    HStack(spacing: 8) {
        IconCell(icon: .snow, isSelected: true, selectionColor: Color(.slCategoryBlue))
        IconCell(icon: .airplane, isSelected: false, selectionColor: Color(.slCategoryBlue))
    }
    .frame(width: 160)
    .padding()
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    HStack(spacing: 8) {
        IconCell(icon: .snow, isSelected: true, selectionColor: Color(.slCategoryBlue))
        IconCell(icon: .airplane, isSelected: false, selectionColor: Color(.slCategoryBlue))
    }
    .frame(width: 160)
    .padding()
    .preferredColorScheme(.dark)
}

//
//  ColorCell.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 17.08.2026.
//
import SwiftUI

private enum Constants {
    static let lineWidth: CGFloat = 2
    static let strokeFrame: CGFloat = 48
    static let circleFrame: CGFloat = 40
}

struct ColorCell: View {
    
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? .slAccent : .clear, lineWidth: Constants.lineWidth)
                .frame(width: Constants.strokeFrame, height: Constants.strokeFrame)
            Circle()
                .fill(color)
                .frame(width: Constants.circleFrame, height: Constants.circleFrame)
        }
        .frame(width: Constants.strokeFrame, height: Constants.strokeFrame, alignment: .center)
        .contentShape(Circle())
    }
}

#Preview {
    ColorCell(color: .slCategoryBlue, isSelected: true)
}

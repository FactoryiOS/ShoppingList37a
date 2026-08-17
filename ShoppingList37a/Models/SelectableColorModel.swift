//
//  ColorSet.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//
import SwiftUI

enum SelectableColor: String, CaseIterable, Identifiable {
    case blue
    case green
    case purple
    case red
    case yellow
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .blue: .slCategoryBlue
        case .green: .slCategoryGreen
        case .purple: .slCategoryPurple
        case .red: .slCategoryRed
        case .yellow: .slCategoryYellow
        }
    }
}

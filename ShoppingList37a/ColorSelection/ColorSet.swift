//
//  ColorSet.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 16.08.2026.
//

import Foundation
import SwiftUI

struct ColorOption: Identifiable, Hashable {
    let id: String
    let color: Color
}

enum ColorSet {
    static let colors: [ColorOption] = [
        .init(id: "blue", color: .slCategoryBlue),
        .init(id: "green", color: .slCategoryGreen),
        .init(id: "purple", color: .slCategoryPurple),
        .init(id: "red", color: .slCategoryRed),
        .init(id: "yellow", color: .slCategoryYellow)
    ]
}

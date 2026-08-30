//
//  Errors.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/15.
//

import SwiftUI

enum Errors {
    static let duplicateName: LocalizedStringKey = "Это название уже используется, пожалуйста, измените его."
}

enum DataError: Error {
    case saveFailed(Error)
}

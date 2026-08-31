//
//  Errors.swift
//  ShoppingList37a
//
//  Created by Kirill Maidanovich on 2026/8/15.
//

import SwiftUI

enum Errors {
    static let duplicateName: LocalizedStringKey = "Это название уже используется, пожалуйста, измените его."
    static let itemAlreadyExists: LocalizedStringKey = "Этот товар уже есть в списке, добавьте другой"
}

enum DataError: Error {
    case saveFailed(Error)
}

//
//  AppFont.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 12/8/26.
//

import SwiftUI

enum AppFont {
    
    /// 34, Regular.
    static let largeTitle = Font.largeTitle
    
    /// 28, SemiBold.
    static let title1 = Font.title.weight(.semibold)
    
    /// 22, SemiBold.
    static let title2 = Font.title2.weight(.semibold)
    
    /// 20, Medium.
    static let title3 = Font.title3.weight(.medium)
    
    /// 20, Semibold.
    static let title3SemiBold = Font.title3.weight(.semibold)
    
    /// 17, Medium.
    static let headline = Font.headline.weight(.medium)
    
    /// 17, Regular.
    static let bodyRegular = Font.body
    
    /// 17, SemiBold.
    static let bodySemiBold = Font.body.weight(.semibold)
    
    /// 16, Regular.
    static let callout = Font.callout
    
    /// 13, Regular.
    static let footnote = Font.footnote
}

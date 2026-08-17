//
//  EmptyStateView.swift
//  ShoppingList37a
//
//  Created by Maria Reshetnikova on 17/08/2026.
//

import SwiftUI

enum EmptyState {
    case shoppingLists
    case shoppingItems
    
    var image: ImageResource {
        switch self {
        case .shoppingLists:
                .imgListsEmpty
            
        case .shoppingItems:
                .imgItemsEmpty
        }
    }
    
    var title: String {
        "Давайте спланируем покупки!"
    }
    
    var subtitle: String {
        switch self {
        case .shoppingLists:
            "Создайте свой первый список"
            
        case .shoppingItems:
            "Начните добавлять товары"
        }
    }
}

/// Displays a placeholder for empty shopping lists or shopping items.
struct EmptyStateView: View {
    
    let state: EmptyState
    
    var body: some View {
        VStack(spacing: 28) {
            
            Image(state.image)
            
            VStack(spacing: 4) {
                
                Text(state.title)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.slTextPrimary)
                    .multilineTextAlignment(.center)
                
                Text(state.subtitle)
                    .font(AppFont.bodyRegular)
                    .foregroundStyle(.slTextPrimary)
                    .multilineTextAlignment(.center)
                
            }
            
        }
    }
}

#Preview("Shopping Lists") {
    EmptyStateView(state: .shoppingLists)
}

#Preview("Shopping Items") {
    EmptyStateView(state: .shoppingItems)
}

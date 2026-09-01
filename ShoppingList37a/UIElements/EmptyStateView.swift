//
//  EmptyStateView.swift
//  ShoppingList37a
//
//  Created by Maria Reshetnikova on 17/08/2026.
//

import SwiftUI

struct EmptyStateView: View {
    
    let state: EmptyState
    
    var body: some View {
        VStack(spacing: 28) {
            Image(state.image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, state.imageHorizontalPadding)
            
            VStack(spacing: 4) {
                Text(state.title)
                    .font(AppFont.title3SemiBold)
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
    
    var imageHorizontalPadding: CGFloat {
        switch self {
        case .shoppingLists:
            49

        case .shoppingItems:
            16
        }
    }
    
    var title: LocalizedStringKey {
        "Давайте спланируем покупки!"
    }

    var subtitle: LocalizedStringKey {
        switch self {
        case .shoppingLists:
            "Создайте свой первый список"

        case .shoppingItems:
            "Начните добавлять товары"
        }
    }
}

#Preview("Shopping Lists") {
    EmptyStateView(state: .shoppingLists)
}

#Preview("Shopping Items") {
    EmptyStateView(state: .shoppingItems)
}

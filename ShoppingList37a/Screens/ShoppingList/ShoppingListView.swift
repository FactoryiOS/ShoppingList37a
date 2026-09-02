//
//  ShoppingListView.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 25.08.2026.
//

import SwiftUI

private enum Constants {
    static let addTitle: LocalizedStringKey = "Добавить товар"
    static let searchPrompt: LocalizedStringKey = "Поиск"
    static let backIcon = "chevron.left"
    static let menuIcon = "ellipsis.circle"
    static let editIcon = "square.and.pencil"
    static let deleteIcon = "trash"
    static let animationDuration = 0.3
}

struct ShoppingListView: View {
    @Bindable var observed: Observed
    @State private var isMenuPresented = false
    var onAdd: () -> Void = { }
    var onEdit: (ShoppingItem) -> Void = { _ in }
    var onDelete: (ShoppingItem) -> Void = { _ in }
    var onToggleBought: (ShoppingItem) -> Void = { _ in }
    var onBack: () -> Void = { }
    var onMenuAction: (MenuAction) -> Void = { _ in }

    var body: some View {
        VStack(spacing: 0) {
            SearchFieldView(placeholder: Constants.searchPrompt, text: $observed.searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            content
            ButtonView(isActive: true, title: Constants.addTitle, action: onAdd)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)
        }
        .background(.slBackgroundPrimary)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if #available(iOS 26.0, *) {
                ToolbarItem(placement: .topBarLeading) { backTitle }
                    .sharedBackgroundVisibility(.hidden)
                ToolbarItem(placement: .topBarTrailing) { menuButton }
                    .sharedBackgroundVisibility(.hidden)
            } else {
                ToolbarItem(placement: .topBarLeading) { backTitle }
                ToolbarItem(placement: .topBarTrailing) { menuButton }
            }
        }
        .overlay {
            if isMenuPresented {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { isMenuPresented = false }
            }
        }
        .overlay {
            if isMenuPresented {
                ZStack(alignment: .topTrailing) {
                    ActionMenuView(
                        onAction: { action in
                            isMenuPresented = false
                            if action == .sort {
                                observed.toggleAlphabeticalSort()
                            } else {
                                onMenuAction(action)
                            }
                        },
                        isSortActive: observed.isSortedAlphabetically
                    )
                    .padding(.trailing, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
        }
    }

    private var backTitle: some View {
        Button(action: onBack) {
            HStack(spacing: 8) {
                Image(systemName: Constants.backIcon)
                    .font(AppFont.bodySemiBold)

                Text(observed.listTitle)
                    .font(AppFont.bodySemiBold)
            }
            .foregroundStyle(.slTextPrimary)
        }
    }
    
    private var menuButton: some View {
        Button {
            withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                isMenuPresented.toggle()
            }
        } label: {
            Image(systemName: Constants.menuIcon)
                .foregroundStyle(.slTextPrimary)
        }
    }

    @ViewBuilder
    private var content: some View {
        if observed.filteredItems.isEmpty {
            Spacer()
            EmptyStateView(state: .shoppingItems)
                .padding(.horizontal, 16)
            Spacer()
        } else {
            itemsList
        }
    }

    private var itemsList: some View {
        List(observed.filteredItems) { item in
            ShoppingItemView(item: item)
                .contentShape(Rectangle())
                .onTapGesture { onToggleBought(item) }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.slBackgroundPrimary)
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        onDelete(item)
                    } label: {
                        Image(systemName: Constants.deleteIcon)
                    }
                    .tint(.slDestructive)

                    Button {
                        onEdit(item)
                    } label: {
                        Image(systemName: Constants.editIcon)
                    }
                    .tint(.slSwipeEdit)
                }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview("Items") {
    NavigationStack {
        ShoppingListView(
            observed: ShoppingListView.Observed(
                listTitle: "Новый год",
                items: [
                    ShoppingItem(name: "текст", quantity: 2),
                    ShoppingItem(name: "текст", quantity: 2),
                    ShoppingItem(name: "Чайник", quantity: 2, isBought: true)
                ]
            )
        )
    }
}

#Preview("Empty") {
    NavigationStack {
        ShoppingListView(
            observed: ShoppingListView.Observed(listTitle: "Новый год")
        )
    }
}

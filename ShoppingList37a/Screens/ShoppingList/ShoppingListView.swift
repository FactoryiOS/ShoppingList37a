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
    static let spacing: CGFloat = 16
    static let titleSpacing: CGFloat = 8
    static let searchVerticalPadding: CGFloat = 8
}

struct ShoppingListView: View {
    @Bindable var observed: Observed
    var onAdd: () -> Void = { }
    var onEdit: (ShoppingItem) -> Void = { _ in }
    var onDelete: (ShoppingItem) -> Void = { _ in }
    var onToggleBought: (ShoppingItem) -> Void = { _ in }
    var onMenu: () -> Void = { }
    var onBack: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            SearchFieldView(placeholder: Constants.searchPrompt, text: $observed.searchText)
                .padding(.horizontal, Constants.spacing)
                .padding(.vertical, Constants.searchVerticalPadding)
            content
            ButtonView(isActive: true, title: Constants.addTitle, action: onAdd)
                .padding(Constants.spacing)
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
    }

    private var backTitle: some View {
        Button(action: onBack) {
            HStack(spacing: Constants.titleSpacing) {
                Image(systemName: Constants.backIcon)
                    .font(AppFont.bodySemiBold)

                Text(observed.listTitle)
                    .font(AppFont.bodySemiBold)
            }
            .foregroundStyle(.slTextPrimary)
        }
    }

    private var menuButton: some View {
        Button(action: onMenu) {
            Image(systemName: Constants.menuIcon)
                .foregroundStyle(.slTextPrimary)
        }
    }

    @ViewBuilder
    private var content: some View {
        if observed.filteredItems.isEmpty {
            Spacer()
            EmptyStateView(state: .shoppingItems)
                .padding(.horizontal, Constants.spacing)
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
                .listRowSeparator(
                    item.id == observed.filteredItems.first?.id ? .hidden : .visible,
                    edges: .top
                )
                .listRowBackground(Color.slBackgroundPrimary)
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

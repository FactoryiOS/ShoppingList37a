//
//  ShoppingListView.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 25.08.2026.
//
import SwiftUI

private enum Constants {
    static let addTitle = "Добавить товар"
    static let searchPrompt = "Поиск"
    static let menuIcon = "ellipsis.circle"
    static let editIcon = "square.and.pencil"
    static let deleteIcon = "trash"
    static let spacing: CGFloat = 16
}

struct ShoppingListView: View {
    @Bindable var observed: Observed
    var onAdd: () -> Void = { }
    var onEdit: (ShoppingItem) -> Void = { _ in }
    var onDelete: (ShoppingItem) -> Void = { _ in }
    var onMenu: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            content
            ButtonView(isActive: true, title: Constants.addTitle, action: onAdd)
                .padding(Constants.spacing)
        }
        .background(.slBackgroundPrimary)
        .navigationTitle(observed.listTitle)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $observed.searchText, prompt: Constants.searchPrompt)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onMenu) {
                    Image(systemName: Constants.menuIcon)
                        .foregroundStyle(.slTextPrimary)
                }
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if observed.items.isEmpty {
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
                .onTapGesture { observed.toggleBought(item) }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.slBackgroundPrimary)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
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

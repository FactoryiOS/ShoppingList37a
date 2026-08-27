//
//  ListsView.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 23/8/26.
//

import SwiftUI

struct ListsView: View {
    
    @Environment(Router.self) private var router

    let observed: Observed

    private enum Constants {
        static let title = "Мои списки"
        static let createButtonTitle = "Создать список"
        static let editIcon = "square.and.pencil"
    }

    var body: some View {
        ZStack {
            Color(.slBackgroundPrimary)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                content
                createButton
            }
        }
    }

    private var header: some View {
        HStack {
            Text(Constants.title)
                .font(AppFont.title1)
                .foregroundStyle(Color(.slTextPrimary))

            Spacer()

            menuButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }

    private var menuButton: some View {
        Button(action: {}, label: {
            Image(.icEllipsis)
                .renderingMode(.template)
                .foregroundStyle(Color(.slTextPrimary))
                .frame(width: 44, height: 44)
        })
    }

    @ViewBuilder
    private var content: some View {
        if observed.lists.isEmpty {
            EmptyStateView(state: .shoppingLists)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            listView
        }
    }

    private var listView: some View {
        List {
            ForEach(observed.lists) { item in
                ListItemCell(item: item)
                    .onTapGesture {
                        router.push(.shoppingList(item))
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            router.push(.editList(item))
                        } label: {
                            Image(systemName: Constants.editIcon)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private var createButton: some View {
        ButtonView(
            isActive: true,
            title: Constants.createButtonTitle,
            action: {
                router.push(.createList)
            }
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

#Preview("Empty") {
    ListsView(observed: .init(lists: []))
        .environment(Router())
}

#Preview("Data") {
    ListsView(observed: .init(lists: ListItem.mocks))
        .environment(Router())
}

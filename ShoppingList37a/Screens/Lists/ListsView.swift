import SwiftUI

private enum Constants {
    static let title: LocalizedStringKey = "Мои списки"
    static let createButtonTitle: LocalizedStringKey = "Создать список"
    static let themeMenuTitle: LocalizedStringKey = "Установить тему"
    static let themeIcon = "circle.lefthalf.filled"
    static let sortTitle: LocalizedStringKey = "Сортировать по Алфавиту"
    static let sortIcon = "arrow.up.arrow.down"
    static let editIcon = "square.and.pencil"
    static let duplicateIcon = "plus.square.on.square"
    static let deleteIcon = "trash"
    static let sortStorageKey = "lists_sorted_alphabetically"
}

struct ListsView: View {
    
    @Environment(Router.self) private var router
    
    let observed: Observed
    var onDuplicate: (ListItem) -> Void = { _ in }
    var onDelete: (ListItem) -> Void = { _ in }

    @AppStorage(AppTheme.storageKey) private var selectedTheme: AppTheme = .system
    @AppStorage(Constants.sortStorageKey) private var sortAlphabetically = false

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
        Menu {
            Section {
                Menu {
                    Picker(selection: $selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.title).tag(theme)
                        }
                    } label: {
                        Text(Constants.themeMenuTitle)
                    }
                } label: {
                    Label(Constants.themeMenuTitle, systemImage: Constants.themeIcon)
                }
            }
            Section {
                Toggle(isOn: $sortAlphabetically) {
                    Label(Constants.sortTitle, systemImage: Constants.sortIcon)
                }
            }
        } label: {
            Image(.icEllipsis)
                .renderingMode(.template)
                .foregroundStyle(Color(.slTextPrimary))
                .frame(width: 44, height: 44)
        }
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
    
    private var displayedLists: [ListItem] {
        guard sortAlphabetically else { return observed.lists }
        return observed.lists.sorted {
            $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
        }
    }

    private var listView: some View {
        List {
            ForEach(displayedLists) { item in
                Section {
                    listRow(item)
                }
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(12)
        .scrollContentBackground(.hidden)
    }

    private func listRow(_ item: ListItem) -> some View {
        cardCell(item)
            .onTapGesture {
                router.push(.shoppingList(item))
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    onDelete(item)
                } label: {
                    Image(systemName: Constants.deleteIcon)
                }
                .tint(.slDestructive)

                Button {
                    onDuplicate(item)
                } label: {
                    Image(systemName: Constants.duplicateIcon)
                }
                .tint(.slSwipeDuplicate)

                Button {
                    router.push(.editList(item))
                } label: {
                    Image(systemName: Constants.editIcon)
                }
                .tint(.slSwipeEdit)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(rowBackground)
    }

    @ViewBuilder
    private func cardCell(_ item: ListItem) -> some View {
        if #available(iOS 26.0, *) {
            ListItemCell(item: item)
                .background(Color(.slBackgroundElevated))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        } else {
            ListItemCell(item: item)
        }
    }

    private var rowBackground: Color {
        if #available(iOS 26.0, *) {
            Color.clear
        } else {
            Color(.slBackgroundElevated)
        }
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

#if DEBUG
#Preview("Empty") {
    ListsView(observed: .init(lists: []))
        .environment(Router())
}

#Preview("Data") {
    ListsView(observed: .init(lists: ListItem.mocks))
        .environment(Router())
}
#endif

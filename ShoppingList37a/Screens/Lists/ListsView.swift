import SwiftUI

private enum Constants {
    static let title: LocalizedStringKey = "Мои списки"
    static let createButtonTitle: LocalizedStringKey = "Создать список"
    static let themeMenuTitle: LocalizedStringKey = "Установить тему"
    static let themeIcon = "circle.lefthalf.filled"
    static let sortTitle: LocalizedStringKey = "Сортировать по Алфавиту"
    static let sortIcon = "arrow.up.arrow.down"
    static let editIcon = "square.and.pencil"
    static let sortStorageKey = "lists_sorted_alphabetically"
}

struct ListsView: View {
    
    @Environment(Router.self) private var router
    
    let observed: Observed
    
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

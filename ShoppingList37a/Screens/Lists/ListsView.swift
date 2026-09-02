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
    static let cardCornerRadius: CGFloat = 20
}

struct SwipeAction: Identifiable {
    let id = UUID()
    let icon: String
    let tint: Color
    let perform: () -> Void
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

    @ViewBuilder
    private var listView: some View {
        if #available(iOS 26.0, *) {
            nativeListView
        } else {
            legacyListView
        }
    }

    private func swipeActions(for item: ListItem) -> [SwipeAction] {
        [
            SwipeAction(icon: Constants.editIcon, tint: .slSwipeEdit) {
                router.push(.editList(item))
            },
            SwipeAction(icon: Constants.duplicateIcon, tint: .slSwipeDuplicate) {
                onDuplicate(item)
            },
            SwipeAction(icon: Constants.deleteIcon, tint: .slDestructive) {
                onDelete(item)
            }
        ]
    }

    private func card(_ item: ListItem) -> some View {
        ListItemCell(item: item)
            .background(Color(.slBackgroundElevated))
    }

    @available(iOS 26.0, *)
    private var nativeListView: some View {
        List {
            ForEach(displayedLists) { item in
                card(item)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cardCornerRadius))
                    .onTapGesture {
                        router.push(.shoppingList(item))
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        ForEach(swipeActions(for: item).reversed()) { action in
                            Button {
                                action.perform()
                            } label: {
                                Image(systemName: action.icon)
                            }
                            .tint(action.tint)
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

    private var legacyListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(displayedLists) { item in
                    SwipeableRow(
                        actions: swipeActions(for: item),
                        cornerRadius: Constants.cardCornerRadius,
                        onTap: { router.push(.shoppingList(item)) },
                        content: { card(item) }
                    )
                }
            }
            .padding(.trailing, 16)
            .padding(.vertical, 6)
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

private enum SwipeableRowLayout {
    static let buttonWidth: CGFloat = 72
    static let openThresholdRatio: CGFloat = 0.5
    static let horizontalInset: CGFloat = 16
}

private struct SwipeableRow<Content: View>: View {

    let actions: [SwipeAction]
    let cornerRadius: CGFloat
    let onTap: () -> Void
    @ViewBuilder let content: () -> Content

    @State private var offset: CGFloat = 0
    @State private var committedOffset: CGFloat = 0

    private var actionsWidth: CGFloat {
        CGFloat(actions.count) * SwipeableRowLayout.buttonWidth
    }

    private var trailingRadius: CGFloat {
        offset < 0 ? 0 : cornerRadius
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            actionsView

            content()
                .frame(maxWidth: .infinity)
                .clipShape(
                    .rect(
                        topLeadingRadius: cornerRadius,
                        bottomLeadingRadius: cornerRadius,
                        bottomTrailingRadius: trailingRadius,
                        topTrailingRadius: trailingRadius
                    )
                )
                .padding(.leading, SwipeableRowLayout.horizontalInset)
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(dragGesture)
                .onTapGesture {
                    if offset == 0 {
                        onTap()
                    } else {
                        close()
                    }
                }
        }
    }

    private var actionsView: some View {
        HStack(spacing: 0) {
            ForEach(actions) { action in
                Button {
                    action.perform()
                    close()
                } label: {
                    Image(systemName: action.icon)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(action.tint)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: actionsWidth)
        .clipShape(
            .rect(
                bottomTrailingRadius: cornerRadius,
                topTrailingRadius: cornerRadius
            )
        )
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 12)
            .onChanged { value in
                guard abs(value.translation.width) > abs(value.translation.height) else { return }
                offset = min(0, max(-actionsWidth, committedOffset + value.translation.width))
            }
            .onEnded { _ in
                let isOpen = offset < -actionsWidth * SwipeableRowLayout.openThresholdRatio
                committedOffset = isOpen ? -actionsWidth : 0
                withAnimation(.snappy) { offset = committedOffset }
            }
    }

    private func close() {
        committedOffset = 0
        withAnimation(.snappy) { offset = 0 }
    }
}

#if DEBUG
#Preview("Empty") {
    ListsView(observed: .init(lists: []), onDelete: {_ in })
        .environment(Router())
}

#Preview("Data") {
    ListsView(
        observed: .init(
            lists: [
                ListItem(
                    id: UUID(),
                    title: "Новый год",
                    icon: .calendar,
                    color: .blue,
                    boughtCount: 10,
                    totalCount: 20
                ),
                ListItem(
                    id: UUID(),
                    title: "Кошке",
                    icon: .paw,
                    color: .green,
                    boughtCount: 1,
                    totalCount: 4
                ),
                ListItem(
                    id: UUID(),
                    title: "Вечеринка малого",
                    icon: .controller,
                    color: .yellow,
                    boughtCount: 9,
                    totalCount: 20
                )
            ]
        ),
        onDelete: { _ in }
    )
    .environment(Router())
}
#endif

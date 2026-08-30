//
//  IconPickerView.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 16/8/26.
//

import SwiftUI

struct IconPickerView: View {
    
    private enum Constants {
        static let title: LocalizedStringKey = "Выберите дизайн"
        static let columnCount = 6
        static let padding: CGFloat = 12
        static let columnSpacing: CGFloat = 8
        static let rowSpacing: CGFloat = 12
        static let contentSpacing: CGFloat = 12
        static let gridOverflow: CGFloat = 4.5
        static let cornerRadius: CGFloat = 12
        static let selectionAnimation: Animation = .easeInOut(duration: 0.15)
    }
    
    let title: LocalizedStringKey
    let icons: [SelectableIcon]
    @Binding var selection: SelectableIcon?
    let selectionColor: Color
    
    private let columns = Array(
        repeating: GridItem(spacing: Constants.columnSpacing),
        count: Constants.columnCount
    )
    
    init(
        title: LocalizedStringKey = Constants.title,
        icons: [SelectableIcon] = SelectableIcon.allCases,
        selection: Binding<SelectableIcon?>,
        selectionColor: Color
    ) {
        self.title = title
        self.icons = icons
        self._selection = selection
        self.selectionColor = selectionColor
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(title)
                .font(AppFont.callout)
                .foregroundStyle(Color(.slTextCounter))
            
            LazyVGrid(columns: columns, spacing: Constants.rowSpacing) {
                ForEach(icons) { icon in
                    Button {
                        selection = icon
                    } label: {
                        IconCell(
                            icon: icon,
                            isSelected: icon == selection,
                            selectionColor: selectionColor
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, -Constants.gridOverflow) // круги выходят за паддинг карточки - как группа иконок в макете
        }
        .padding(Constants.padding)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .animation(Constants.selectionAnimation, value: selection)
    }
}

#Preview("Light") {
    @Previewable @State var selection: SelectableIcon? = .snow

    ZStack {
        Color(.slBackgroundPrimary)
            .ignoresSafeArea()

        IconPickerView(selection: $selection, selectionColor: Color(.slCategoryBlue))
            .padding()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    @Previewable @State var selection: SelectableIcon? = .snow

    ZStack {
        Color(.slBackgroundPrimary)
            .ignoresSafeArea()

        IconPickerView(selection: $selection, selectionColor: Color(.slCategoryBlue))
            .padding()
    }
    .preferredColorScheme(.dark)
}

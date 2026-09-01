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
        static let selectionAnimation: Animation = .easeInOut(duration: 0.15)
    }
    
    let title: LocalizedStringKey
    let icons: [SelectableIcon]
    @Binding var selection: SelectableIcon?
    let selectionColor: Color
    
    private let columns = Array(
        repeating: GridItem(spacing: 8),
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
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(AppFont.callout)
                .foregroundStyle(Color(.slTextCounter))
            
            LazyVGrid(columns: columns, spacing: 12) {
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
            .padding(.horizontal, -4.5)
        }
        .padding(12)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(Constants.selectionAnimation, value: selection)
    }
}

#Preview() {
    @Previewable @State var selection: SelectableIcon? = .snow

    ZStack {
        Color(.slBackgroundPrimary)
            .ignoresSafeArea()

        IconPickerView(selection: $selection, selectionColor: Color(.slCategoryBlue))
            .padding()
    }
}

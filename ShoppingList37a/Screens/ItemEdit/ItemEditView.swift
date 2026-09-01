//
//  ItemEditView.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 20.08.2026.
//

import SwiftUI

private enum Constants {
    static let cancelTitle: LocalizedStringKey = "Отменить"
    static let doneTitle: LocalizedStringKey = "Готово"
    static let namePlaceholder: LocalizedStringKey = "Название"
    static let quantityPlaceholder: LocalizedStringKey = "Количество"
    static let unitLabel: LocalizedStringKey = "Ед.изм.:"
}

struct ItemEditView: View {
    @Bindable var observed: Observed
    var onCancel: () -> Void = { }
    var onDone: (String, Int, ShoppingItemUnit) -> Void = { _, _, _ in }

    var body: some View {
        VStack(spacing: 16) {
            header
            TextFieldView(
                placeholder: Constants.namePlaceholder,
                text: $observed.name,
                isError: observed.isNameDuplicate,
                errorMessage: observed.nameError
            )
            HStack(spacing: 16) {
                TextFieldView(
                    placeholder: Constants.quantityPlaceholder,
                    text: $observed.quantity,
                    isError: false,
                    errorMessage: nil
                )
                .keyboardType(.numberPad)

                unitPicker
            }
            Spacer()
        }
        .padding(16)
        .background(.slBackgroundPrimary)
    }

    private var unitPicker: some View {
        Menu {
            Picker(selection: $observed.unit) {
                ForEach(ShoppingItemUnit.allCases, id: \.self) { unit in
                    Text(unit.title).tag(unit)
                }
            } label: {
                Text(verbatim: "")
            }
        } label: {
            HStack {
                Text(Constants.unitLabel)
                    .foregroundStyle(.slTextSecondary)

                Spacer()

                HStack(spacing: 4) {
                    Text(observed.unit.title)

                    Image(systemName: "chevron.up.chevron.down")
                }
                .foregroundStyle(.slAccent)
            }
            .font(AppFont.bodyRegular)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(.slBackgroundElevated)
            .cornerRadius(12)
        }
    }

    private var header: some View {
        ZStack {
            Text(observed.mode.title)
                .font(AppFont.bodySemiBold)
                .foregroundStyle(.slTextPrimary)

            HStack {
                Button(Constants.cancelTitle) {
                    onCancel()
                }
                .font(AppFont.bodyRegular)
                .foregroundStyle(.slTextSecondary)

                Spacer()

                Button(Constants.doneTitle) {
                    guard let quantity = Int(observed.quantity) else { return }
                    onDone(observed.name, quantity, observed.unit)
                }
                .font(AppFont.bodySemiBold)
                .foregroundStyle(observed.isDoneEnabled ? .slAccent : .slTextSecondary)
                .disabled(!observed.isDoneEnabled)
            }
        }
    }
}

#Preview("create") {
    ItemEditView(observed: ItemEditView.Observed())
        .preferredColorScheme(.light)
}

#Preview("edit") {
    ItemEditView(
        observed: ItemEditView.Observed(
            mode: .edit,
            name: "Чайник",
            quantity: "1",
            unit: .pieces
        )
    )
    .preferredColorScheme(.dark)
}

#Preview("duplicate") {
    ItemEditView(
        observed: ItemEditView.Observed(
            name: "Чайник",
            existingNames: ["чайник"]
        )
    )
    .preferredColorScheme(.light)
}

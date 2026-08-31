//
//  ItemEditView.swift
//  ShoppingList37a
//
//  Created by Ignat Klimenko on 20.08.2026.
//
import SwiftUI

private enum Constants {
    static let cancelTitle = "Отменить"
    static let doneTitle = "Готово"
    static let namePlaceholder = "Название"
    static let quantityPlaceholder = "Количество"
    static let unitPlaceholder = "Ед. изм."
    static let spacing: CGFloat = 16
}

struct ItemEditView: View {
    @Bindable var observed: Observed
    var onCancel: () -> Void = { }
    var onDone: (String, Int, ShoppingItemUnit) -> Void = { _, _, _ in }

    var body: some View {
        VStack(spacing: Constants.spacing) {
            header
            TextFieldView(
                placeholder: Constants.namePlaceholder,
                text: $observed.name,
                isError: observed.isNameDuplicate,
                errorMessage: observed.nameError
            )
            HStack(spacing: Constants.spacing) {
                TextFieldView(
                    placeholder: Constants.quantityPlaceholder,
                    text: $observed.quantity,
                    isError: false,
                    errorMessage: nil
                )
                .keyboardType(.numberPad)

                TextFieldView(
                    placeholder: Constants.unitPlaceholder,
                    text: $observed.unit,
                    isError: false,
                    errorMessage: nil
                )
            }
            Spacer()
        }
        .padding(Constants.spacing)
        .background(.slBackgroundPrimary)
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
                    guard let quantity = Int(observed.quantity),
                          let unit = ShoppingItemUnit(input: observed.unit) else { return }
                    onDone(observed.name, quantity, unit)
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
            unit: "шт"
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

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
    static let spacing: CGFloat = 16
    static let unitValueSpacing: CGFloat = 4
    static let fieldHeight: CGFloat = 54
    static let fieldCornerRadius: CGFloat = 12
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
                isError: false,
                errorMessage: nil
            )
            HStack(spacing: Constants.spacing) {
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
        .padding(Constants.spacing)
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

                HStack(spacing: Constants.unitValueSpacing) {
                    Text(observed.unit.title)

                    Image(systemName: "chevron.up.chevron.down")
                }
                .foregroundStyle(.slAccent)
            }
            .font(AppFont.bodyRegular)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: Constants.fieldHeight)
            .background(.slBackgroundElevated)
            .cornerRadius(Constants.fieldCornerRadius)
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

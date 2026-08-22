import SwiftUI

struct CreateListView: View {
	@Environment(\.dismiss) private var dismiss
	
	@State private var observed: CreateListObserved
	var onSave: () -> Void = {}
	
	init(observed: @autoclosure @MainActor () -> CreateListObserved = CreateListObserved()) {
		_observed = State(wrappedValue: observed())
	}
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Button(
					action: {
						dismiss()
					},
					label: {
						HStack(spacing: 0) {
							Image(systemName: "chevron.left")
								.font(.system(size: 16, weight: .regular))
								.foregroundStyle(Color(.slTextPrimary))
								.frame(width: 28, height: 44)
							
							Text(observed.mode == .create ? "Создать список" : "Редактировать список")
								.font(.system(size: 17, weight: .medium))
								.foregroundStyle(Color(.slTextPrimary))
								.lineSpacing(22 - 17)
								.padding(.leading, 8) 
						}
					}
				)
				.buttonStyle(.plain)
				
				Spacer()
			}
			.padding(.horizontal, 16)
			.frame(height: 52)
			.background(Color(.slBackgroundPrimary))
			
			ScrollView {
				VStack(spacing: 16) {
					
					TextFieldView(
						placeholder: "Введите название списка",
						text: $observed.listName,
						isError: false,
						errorMessage: nil
					)
					.padding(.top, 12)
					
					ColorSelectionView(
						selectedColor: $observed.selectedColor,
						title: observed.mode == .create ? "Выберите дизайн" : "Цвет"
					)
					
					IconPickerView(
						selection: $observed.selectedIcon,
						selectionColor: observed.selectedColor?.color ?? Color(.slAccent)
					)
				}
				.padding(.horizontal, 16)
			}
			.background(Color(.slBackgroundPrimary).ignoresSafeArea())
			
			VStack {
				ButtonView(
					isActive: observed.isSaveEnabled,
					title: observed.mode.actionButtonTitle,
					action: {
						onSave()
						dismiss()
					}
				)
				.padding(.horizontal, 16)
				.padding(.bottom, 8)
			}
			.background(Color(.slBackgroundPrimary))
		}
		.navigationBarBackButtonHidden(true)
	}
}

#Preview("Создание списка") {
	NavigationStack {
		CreateListView(observed: CreateListObserved(mode: .create))
	}
}

#Preview("Редактирование списка") {
	NavigationStack {
		CreateListView(
			observed: CreateListObserved(
				mode: .edit,
				listName: "Новый год",
				selectedColor: .red,
				selectedIcon: .calendar
			)
		)
	}
}

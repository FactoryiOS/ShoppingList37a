import SwiftUI

struct CreateListView: View {
    @Environment(Router.self) private var router
	
	@State private var observed: Observed
	var onSave: () -> Void = {}
	
	init(observed: @autoclosure @MainActor () -> Observed = Observed()) {
		_observed = State(wrappedValue: observed())
	}
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Button(
                    action: {
                        router.pop()
                    },
					label: {
						HStack(spacing: 0) {
							Image(systemName: "chevron.left")
								.font(AppFont.callout)
								.foregroundStyle(Color(.slTextPrimary))
								.frame(width: 28, height: 44)
							
							Text(observed.mode.title)
								.font(AppFont.headline)
								.foregroundStyle(Color(.slTextPrimary))
								.padding(.leading, 8)
						}
					}
				)
				.buttonStyle(.plain)
				
				Spacer()
			}
			.padding(.horizontal, 16)
			.frame(height: 52)
			
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
						title: observed.mode.colorSectionTitle
					)
					
					IconPickerView(
						selection: $observed.selectedIcon,
						selectionColor: observed.currentSelectionColor
					)
				}
				.padding(.horizontal, 16)
			}
			
			VStack {
				ButtonView(
					isActive: observed.isSaveEnabled,
					title: observed.mode.actionButtonTitle,
                    action: {
                        onSave()
                        router.pop()
                    }
				)
				.padding(.horizontal, 16)
				.padding(.bottom, 8)
			}
		}
		.background(Color(.slBackgroundPrimary).ignoresSafeArea())
		.navigationBarBackButtonHidden(true)
	}
}

#Preview("Создание списка") {
	NavigationStack {
		CreateListView(observed: CreateListView.Observed(mode: .create))
	}
    .environment(Router())
}

#Preview("Редактирование списка") {
	NavigationStack {
		CreateListView(
			observed: CreateListView.Observed(
				mode: .edit,
				listName: "Новый год",
				selectedColor: .red,
				selectedIcon: .calendar
			)
		)
	}
    .environment(Router())
}

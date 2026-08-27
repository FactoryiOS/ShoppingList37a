import SwiftUI

struct CreateListView: View {
    @Environment(Router.self) private var router
    
    var observed: Observed
    var onSave: () -> Void = {}
    
    var body: some View {
        @Bindable var observed = observed
        
        VStack(spacing: 0) {
            navigationHeader
            
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
            
            saveButtonBlock
        }
        .background(Color(.slBackgroundPrimary).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Subviews
    
    private var navigationHeader: some View {
        HStack {
            Button(
                action: { router.pop() },
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
    }
    
    private var saveButtonBlock: some View {
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

// MARK: - Previews
#Preview("Создание списка") {
    CreateListView(observed: .init(mode: .create))
        .environment(Router())
}

#Preview("Редактирование списка") {
    CreateListView(
        observed: .init(
            mode: .edit,
            listName: "Новый год",
            selectedColor: .red,
            selectedIcon: .calendar
        )
    )
    .environment(Router())
}
		)
	}
    .environment(Router())
}

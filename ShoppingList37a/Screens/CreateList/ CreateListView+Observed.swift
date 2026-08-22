import SwiftUI

enum CreateListMode {
	case create
	case edit
	
	var title: String {
		switch self {
		case .create: "Создать список"
		case .edit: "Редактировать список"
		}
	}
	
	var actionButtonTitle: String {
		switch self {
		case .create: "Создать"
		case .edit: "Сохранить"
		}
	}
}

@MainActor
@Observable
final class CreateListObserved {
	let mode: CreateListMode
	var listName: String
	var selectedColor: SelectableColor?
	var selectedIcon: SelectableIcon?
	
	var isSaveEnabled: Bool {
		!listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
		&& selectedColor != nil
		&& selectedIcon != nil
	}
	
	var currentBorderColor: Color {
		selectedColor?.color ?? Color.gray.opacity(0.3)
	}
	
	init(
		mode: CreateListMode = .create,
		listName: String = "",
		selectedColor: SelectableColor? = nil,
		selectedIcon: SelectableIcon? = nil
	) {
		self.mode = mode
		self.listName = listName
		self.selectedColor = selectedColor
		self.selectedIcon = selectedIcon
	}
}

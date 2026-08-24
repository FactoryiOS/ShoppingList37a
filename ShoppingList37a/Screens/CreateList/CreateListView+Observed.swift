import SwiftUI

extension CreateListView {
	
	enum Mode {
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
		
		var colorSectionTitle: String {
			switch self {
			case .create: "Выберите дизайн"
			case .edit: "Цвет"
			}
		}
	}
	
	@MainActor
	@Observable
	final class Observed {
		let mode: Mode
		var listName: String
		var selectedColor: SelectableColor?
		var selectedIcon: SelectableIcon?
		
		var isSaveEnabled: Bool {
			!listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
			&& selectedColor != nil
			&& selectedIcon != nil
		}
		
		var currentSelectionColor: Color {
			selectedColor?.color ?? Color(.slAccent)
		}
		
		init(
			mode: Mode = .create,
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
}

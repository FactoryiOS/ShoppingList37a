import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
	case system = "Системная"
	case light = "Светлая"
	case dark = "Темная"
	
	static let storageKey = "selected_app_theme"

	var id: String { self.rawValue }

	var title: LocalizedStringKey {
		switch self {
		case .system: "Системная"
		case .light: "Светлая"
		case .dark: "Темная"
		}
	}

	var colorScheme: ColorScheme? {
		switch self {
		case .system: return nil
		case .light: return .light
		case .dark: return .dark
		}
	}
}

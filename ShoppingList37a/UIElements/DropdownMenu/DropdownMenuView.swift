import SwiftUI

struct DropdownMenuView: View {
	@Binding var selectedTheme: AppTheme
	@Binding var isThemeExpanded: Bool
	let onDismiss: () -> Void // Колбэк для закрытия меню извне

	var body: some View {
		VStack(spacing: 0) {
			if !isThemeExpanded {
				mainMenuLayers
			} else {
				themeSelectionLayers
			}
		}
		.frame(width: 250)
		.background(Color(.slBackgroundElevated))
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
		.transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .topTrailing)))
	}

	// MARK: - Первый уровень меню
	private var mainMenuLayers: some View {
		VStack(spacing: 0) {
			MenuRow(
				title: "Установить тему",
				font: AppFont.bodyRegular,
				leadingIcon: .icChevron,
				trailingIcon: .icThemeCircle,
				height: 44,
				action: { isThemeExpanded = true }
			)
			
			Rectangle()
				.fill(selectedTheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.08))
				.frame(height: 8)
			
			MenuRow(
				title: "Сортировать по Алфавиту",
				font: AppFont.bodyRegular,
				systemTrailingIcon: "arrow.up.arrow.down",
				height: 52,
				action: {
					// Здесь в будущем можно вызвать сортировку
					onDismiss()
				}
			)
		}
	}

	// MARK: - Второй уровень (Выбор тем)
	private var themeSelectionLayers: some View {
		VStack(spacing: 0) {
			MenuRow(
				title: "Установить тему",
				font: AppFont.headline,
				leadingIcon: .icChevron,
				trailingIcon: .icThemeCircle,
				chevronRotation: 90,
				height: 52,
				action: { isThemeExpanded = false }
			)
			
			divider
			
			ForEach(AppTheme.allCases) { theme in
				MenuRow(
					title: theme.rawValue,
					font: AppFont.bodyRegular,
					systemTrailingIcon: selectedTheme == theme ? "checkmark" : nil,
					height: 52,
					action: {
						selectedTheme = theme
						onDismiss()
					}
				)
				
				if theme.id != AppTheme.allCases.last?.id {
					divider
				}
			}
		}
	}

	private var divider: some View {
		Rectangle()
			.fill(Color(.slTextPrimary).opacity(0.15))
			.frame(height: 1)
	}
}

// MARK: - Переиспользуемая строка меню
private struct MenuRow: View {
	let title: String
	let font: Font
	var leadingIcon: ImageResource?
	var trailingIcon: ImageResource?
	var systemTrailingIcon: String?
	var chevronRotation: Double = 0
	let height: CGFloat
	let action: () -> Void

	var body: some View {
		Button(
			action: {
				withAnimation(.easeInOut(duration: 0.15)) {
					action()
				}
			},
			label: {
				HStack(spacing: 0) {
					if let leadingIcon {
						Image(leadingIcon)
							.renderingMode(.template)
							.foregroundStyle(Color(.slTextPrimary))
							.rotationEffect(.degrees(chevronRotation))
							.frame(width: 24, height: 24)
							.padding(.leading, 7)
					}
					
					Text(title)
						.font(font)
						.foregroundStyle(Color(.slTextPrimary))
						.padding(.leading, leadingIcon == nil ? 16 : 0)
					
					Spacer()
					
					if let trailingIcon {
						Image(trailingIcon)
							.renderingMode(.template)
							.foregroundStyle(Color(.slTextPrimary))
							.padding(.trailing, 16)
					} else if let systemTrailingIcon {
						Image(systemName: systemTrailingIcon)
							.font(.system(size: 16))
							.foregroundStyle(Color(.slTextPrimary))
							.padding(.trailing, 16)
					}
				}
				.frame(height: height)
			}
		)
	}
}

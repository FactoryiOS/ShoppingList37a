import SwiftUI

struct ContentView: View {
	
	@Environment(Router.self) private var router
	@AppStorage("selected_app_theme") private var selectedTheme: AppTheme = .system
	
	var body: some View {
		@Bindable var router = router
		
		NavigationStack(path: $router.navigationPath) {
			ListsView(observed: .init(lists: ListItem.mocks))
				.navigationDestination(for: Route.self) { route in
					switch route {
					case .createList:
						CreateListView(observed: .init(mode: .create))
						
					case .editList(let list):
						CreateListView(
							observed: .init(
								mode: .edit,
								listName: list.title,
								selectedColor: list.color,
								selectedIcon: list.icon
							)
						)
						
					case .shoppingList(let list):
						ShoppingListView(observed: .init(listTitle: list.title))
					}
				}
		}
		.sheet(item: $router.presentedModal) { modal in
			switch modal {
			case .createItem:
				ItemEditView(observed: .init(mode: .create))
				
			case .editItem(let item):
				ItemEditView(
					observed: .init(
						mode: .edit,
						name: item.name,
						quantity: String(item.quantity),
						unit: item.unit.title
					)
				)
			}
		}
		.preferredColorScheme(selectedTheme.colorScheme)
	}
}

#Preview {
	ContentView()
		.environment(Router())
}

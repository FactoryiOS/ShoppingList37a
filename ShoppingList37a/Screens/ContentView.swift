//
//  ContentView.swift
//  ShoppingList37a
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SDShoppingList.title) private var sdList: [SDShoppingList]
    @State private var repository: Repository?
    
    var body: some View {
        ListsView(observed: .init(lists: sdList.map { ListItem(from: $0)}))
            .task {
                if repository == nil {
                    repository = Repository(context: context)
                }
            }
    }
}

#Preview {
    ContentView()
}

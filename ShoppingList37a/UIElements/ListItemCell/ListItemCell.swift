//
//  ListItemCell.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 19/8/26.
//

import SwiftUI

struct ListItemCell: View {

    let item: ListItem

    var body: some View {
        HStack(spacing: 16) {
            icon
            Text(item.title)
                .font(AppFont.title3)
                .foregroundStyle(Color(.slTextPrimary))
                .lineLimit(1)
            Spacer()
            counter
                .fixedSize()
        }
        .padding(16)
        .background(Color(.slBackgroundElevated))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var icon: some View {
        Image(item.icon.assetName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
            .foregroundStyle(Color(.slIconForeground))
            .padding(16)
            .background(item.color.color)
            .clipShape(Circle())
    }
    
    private var counter: some View {
        (
        Text(verbatim: "\(item.boughtCount)/")
            .font(AppFont.bodyRegular)
            .foregroundStyle(Color(.slTextCounter))
        + Text(verbatim: "\(item.totalCount)")
            .font(AppFont.headline)
            .foregroundStyle(Color(.slTextPrimary))
        )
        .monospacedDigit()
    }
    
}

#Preview {
    ZStack {
        Color(.slBackgroundPrimary)
            .ignoresSafeArea()
        
        ListItemCell(item: .mock)
            .padding()
    }
}

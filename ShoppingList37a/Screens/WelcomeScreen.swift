//
//  WelcomeScreen.swift
//  ShoppingList37a
//
//  Created by Maria Reshetnikova on 21/08/2026.
//

import SwiftUI

private enum Constants {
    static let title: LocalizedStringKey = "Добро пожаловать!"
    static let headline: LocalizedStringKey = "Никогда не забывайте,\nчто нужно купить"
    static let supportingText: LocalizedStringKey = "Создавайте списки\nи не переживайте о покупках"
    static let buttonTitle: LocalizedStringKey = "Начать"
}

struct WelcomeScreen: View {

    let onStart: () -> Void

    var body: some View {
        ZStack {
            Color.slBackgroundPrimary
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(Constants.title)
                    .font(AppFont.largeTitle)
                    .foregroundStyle(.slTextPrimary)
                
                Spacer()
                    .frame(height: 48)
                
                Image(.imgOnboarding)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 49)
                
                Spacer()
                    .frame(height: 48)
                
                VStack(spacing: 12) {
                    Text(Constants.headline)
                        .font(AppFont.title2)
                        .foregroundStyle(.slTextPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(Constants.supportingText)
                        .font(AppFont.bodyRegular)
                        .foregroundStyle(.slTextPrimary)
                        .multilineTextAlignment(.center)
                }
                
                Spacer(minLength: 90.3)

                ButtonView(
                    isActive: true,
                    title: Constants.buttonTitle,
                    action: onStart
                )
                .padding(.horizontal, 16)
            }
            .padding(.top, 39.3)
            .padding(.bottom, 20)
        }
    }
}

#Preview() {
    WelcomeScreen(onStart: {})
}

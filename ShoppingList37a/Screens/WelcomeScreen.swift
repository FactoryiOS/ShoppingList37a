//
//  WelcomeScreen.swift
//  ShoppingList37a
//
//  Created by Maria Reshetnikova on 21/08/2026.
//

import SwiftUI

struct WelcomeScreen: View {
    
    let onStart: () -> Void
    
    private enum Constants {
        static let title: LocalizedStringKey = "Добро пожаловать!"
        static let headline: LocalizedStringKey = "Никогда не забывайте,\nчто нужно купить"
        static let supportingText: LocalizedStringKey = "Создавайте списки\nи не переживайте о покупках"
        static let buttonTitle: LocalizedStringKey = "Начать"
        
        static let topPadding: CGFloat = 39.3
        static let titleToImageSpacing: CGFloat = 48
        static let imageToTextSpacing: CGFloat = 48
        static let textSpacing: CGFloat = 12
        static let textToButtonSpacing: CGFloat = 90.3
        static let bottomPadding: CGFloat = 20
        static let horizontalPadding: CGFloat = 49
        static let buttonHorizontalPadding: CGFloat = 16
    }
    
    var body: some View {
        ZStack {
            Color.slBackgroundPrimary
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(Constants.title)
                    .font(AppFont.largeTitle)
                    .foregroundStyle(.slTextPrimary)
                
                Spacer()
                    .frame(height: Constants.titleToImageSpacing)
                
                Image(.imgOnboarding)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, Constants.horizontalPadding)
                
                Spacer()
                    .frame(height: Constants.imageToTextSpacing)
                
                VStack(spacing: Constants.textSpacing) {
                    Text(Constants.headline)
                        .font(AppFont.title2)
                        .foregroundStyle(.slTextPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(Constants.supportingText)
                        .font(AppFont.bodyRegular)
                        .foregroundStyle(.slTextPrimary)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                    .frame(height: Constants.textToButtonSpacing)
                
                ButtonView(
                    isActive: true,
                    title: Constants.buttonTitle,
                    action: onStart
                )
                .padding(.horizontal, Constants.buttonHorizontalPadding)
            }
            .padding(.top, Constants.topPadding)
            .padding(.bottom, Constants.bottomPadding)
        }
    }
}

#Preview("Light") {
    WelcomeScreen(onStart: {})
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    WelcomeScreen(onStart: {})
        .preferredColorScheme(.dark)
}

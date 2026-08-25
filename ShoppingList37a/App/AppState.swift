//
//  AppState.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 22/8/26.
//

import Observation

enum AppRoot {
    case welcome
    case main
}

@Observable
@MainActor final class AppState {
    
    private(set) var root: AppRoot
    
    @ObservationIgnored
    private var storage: OnboardingStorage
    
    init(storage: OnboardingStorage = UserDefaultsOnboardingStorage()) {
        self.storage = storage
        root = storage.hasCompletedOnboarding ? .main : .welcome
    }
    
    func completeWelcome() {
        storage.hasCompletedOnboarding = true
        root = .main
    }
}

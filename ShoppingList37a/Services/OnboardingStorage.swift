//
//  OnboardingStorage.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 22/8/26.
//

import Foundation

nonisolated protocol OnboardingStorage {
    var hasCompletedOnboarding: Bool { get set }
}

nonisolated final class UserDefaultsOnboardingStorage: OnboardingStorage {
    
    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    var hasCompletedOnboarding: Bool {
        get { defaults.bool(forKey: Keys.hasCompletedOnboarding) }
        set { defaults.set(newValue, forKey: Keys.hasCompletedOnboarding) }
    }
}

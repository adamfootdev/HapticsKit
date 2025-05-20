//
//  HapticsKitConfiguration.swift
//  HapticsKit
//
//  Created by Adam Foot on 20/05/2025.
//

import Foundation

public struct HapticsKitConfiguration: Sendable {

    /// A `String` containing the default storage key for enabling haptic feedback.
    public static let defaultStorageKey: String = "HKHapticFeedbackEnabled"
    
    /// The `UserDefaults` data store.
    public var userDefaults: UserDefaults
    
    /// A `String` containing the data storage key.
    public var storageKey: String
    
    /// Initialises a new `HapticsKitConfiguration` object.
    /// - Parameters:
    ///   - userDefaults: The `UserDefaults` data store.
    ///   - storageKey: A `String` containing the data storage key.
    public init(
        userDefaults: UserDefaults = .standard,
        storageKey: String = HapticsKitConfiguration.defaultStorageKey
    ) {
        self.userDefaults = userDefaults
        self.storageKey = storageKey

        userDefaults.register(defaults: [
            storageKey: true
        ])
    }


    // MARK: - Previews

    public static let preview: HapticsKitConfiguration = {
        let configuration = HapticsKitConfiguration(
            userDefaults: .standard,
            storageKey: defaultStorageKey
        )

        return configuration
    }()
}

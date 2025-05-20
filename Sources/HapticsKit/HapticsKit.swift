//
//  HapticsKit.swift
//  HapticsKit
//
//  Created by Adam Foot on 05/09/2023.
//

import Foundation

#if os(iOS)
import UIKit
import CoreHaptics
#elseif os(watchOS)
import WatchKit
#endif

@MainActor @Observable
public final class HapticsKit {

    /// An initialised `HapticsKit` object.
    private static var initializedHapticsKit: HapticsKit?
    
    /// The shared `HapticsKit` object to use for creating haptics feedback.
    public static var shared: HapticsKit {
        if let initializedHapticsKit {
            return initializedHapticsKit
        } else {
            fatalError("Please initialize HapticsKit by calling HapticsKit.configure(…) first.")
        }
    }
    
    /// The configured values to use in HapticsKit.
    public private(set) var configuration: HapticsKitConfiguration


    // MARK: - Init

    private init(configuration: HapticsKitConfiguration) {
        self.configuration = configuration
    }


    // MARK: - Configuration
    
    /// Configures `HapticsKit`.
    /// - Parameter configuration: A `HapticsKitConfiguration` object.
    /// - Returns: The initialised `HapticsKit` object.
    @discardableResult
    public static func configure(
        with configuration: HapticsKitConfiguration
    ) -> HapticsKit {
        if let initializedHapticsKit {
            initializedHapticsKit.configuration = configuration
            return initializedHapticsKit
        } else {
            let object = HapticsKit(configuration: configuration)
            initializedHapticsKit = object
            return object
        }
    }


    // MARK: - Availability

    /// A  `Bool`  indicating whether haptic feedback is supported on the user's device.
    public static var hapticFeedbackSupported: Bool {
        #if os(iOS)
            #if targetEnvironment(simulator)
            return UIDevice.current.userInterfaceIdiom == .phone
            #else
            return CHHapticEngine.capabilitiesForHardware().supportsHaptics
            #endif

        #elseif os(watchOS)
            return true

        #else
            return false
        #endif
    }


    // MARK: - Actions

    #if os(iOS)
    /// Plays the specified notification haptic feedback type.
    /// - Parameter type: The notification haptic feedback to play.
    public func performNotification(
        _ type: UINotificationFeedbackGenerator.FeedbackType
    ) {
        if checkHapticFeedbackEnabled() {
            UINotificationFeedbackGenerator().notificationOccurred(type)
        }
    }

    /// Plays the specified impact haptic feedback style at the specified intensity level.
    /// - Parameters:
    ///   - style: The impact haptic feedback style to play. Defaults to medium.
    ///   - intensity: The intensity at which to play the impact haptic feedback. Defaults to 100%.
    public func performImpact(
        _ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        at intensity: CGFloat = 1.0
    ) {
        if checkHapticFeedbackEnabled() {
            UIImpactFeedbackGenerator(style: style).impactOccurred(intensity: intensity)
        }
    }

    /// Plays a selection haptic feedback.
    public func performSelection() {
        if checkHapticFeedbackEnabled() {
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }

    #elseif os(watchOS)
    /// Plays the specified haptic feedback.
    /// - Parameter haptic: The haptic feedback type to play.
    public func perform(_ haptic: WKHapticType) {
        if checkHapticFeedbackEnabled() {
            WKInterfaceDevice.current().play(haptic)
        }
    }
    #endif


    // MARK: - Stored Values
    
    /// A `Bool` indicating whether haptic feedback is enabled.
    public var hapticFeedbackEnabled: Bool {
        get {
            access(keyPath: \.hapticFeedbackEnabled)

            if configuration.userDefaults.object(
                forKey: configuration.storageKey
            ) != nil {
                return configuration.userDefaults.bool(
                    forKey: configuration.storageKey
                )
            } else {
                return true
            }
        }

        set {
            withMutation(keyPath: \.hapticFeedbackEnabled) {
                if (newValue != hapticFeedbackEnabled) || (configuration.userDefaults.object(
                    forKey: configuration.storageKey
                ) == nil) {
                    configuration.userDefaults.set(
                        newValue,
                        forKey: configuration.storageKey
                    )
                }
            }
        }
    }

    /// Checks if haptic feedback is enabled on the device.
    /// - Returns: A `Bool` indicating whether haptic feedback is enabled.
    private func checkHapticFeedbackEnabled() -> Bool {
        guard HapticsKit.hapticFeedbackSupported else {
            return false
        }

        return hapticFeedbackEnabled
    }


    // MARK: - Previews

    public static var preview: HapticsKit = {
        let haptics = HapticsKit.configure(with: .preview)
        return haptics
    }()
}

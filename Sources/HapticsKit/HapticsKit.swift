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

@MainActor
public enum HapticsKit {

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

    #if os(iOS)
    /// Plays the specified notification haptic feedback type.
    /// - Parameter type: The notification haptic feedback to play.
    public static func performNotification(
        _ type: UINotificationFeedbackGenerator.FeedbackType
    ) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }

    /// Plays the specified impact haptic feedback style at the specified intensity level.
    /// - Parameters:
    ///   - style: The impact haptic feedback style to play. Defaults to medium.
    ///   - intensity: The intensity at which to play the impact haptic feedback. Defaults to 100%.
    public static func performImpact(
        _ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        at intensity: CGFloat = 1.0
    ) {
        UIImpactFeedbackGenerator(style: style).impactOccurred(intensity: intensity)
    }

    /// Plays a selection haptic feedback.
    public static func performSelection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }

    #elseif os(watchOS)
    public static func perform(_ haptic: WKHapticType) {
        WKInterfaceDevice.current().play(haptic)
    }
    #endif
}

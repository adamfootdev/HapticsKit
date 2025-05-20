# HapticsKit

![Platform](https://img.shields.io/badge/platforms-iOS%2FiPadOS%2017.0%2B%20%7C%20macOS%2014.0%2B%20%7C%20tvOS%2017.0%2B%20%7C%20visionOS%201.0%2B%20%7C%20watchOS%2010.0%2B-blue)

HapticsKit provides developers for Apple platforms with the ability to quickly add haptic feedback to their apps.

HapticsKit is available on all Apple platforms but is only functional on devices which have support for haptic feedback (iPhone & Apple Watch).

1. [Requirements](#requirements)
2. [Integration](#integration)
3. [Usage](#usage)
    - [HapticsKitConfiguration](#hapticskitconfiguration)
    - [HapticsKit](#hapticskit)
4. [Testing Haptic Feedback](#testing-haptic-feedback)
5. [Other Packages](#other-packages)
    - [AboutKit](https://github.com/adamfootdev/AboutKit)
    - [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)
    - [HelpKit](https://github.com/adamfootdev/HelpKit)

## Requirements

- iOS/iPadOS 17.0+
- macOS 14.0+
- tvOS 17.0+
- visionOS 1.0+
- watchOS 10.0+
- Xcode 15.0+

## Integration

### Swift Package Manager

HapticsKit can be added to your app via Swift Package Manager in Xcode. Add to your project like so:

```swift
dependencies: [
    .package(url: "https://github.com/adamfootdev/HapticsKit.git", from: "2.0.7")
]
```

## Usage

To start using the framework, you'll need to import it first:

```swift
import HapticsKit
```

### HapticsKitConfiguration

This is a struct containing all of the relevant details required to configure HapticsKit. It can be created like so:

```swift
let configuration = HapticsKitConfiguration(
    userDefaults: UserDefaults.standard, 
    storageKey: "hapticFeedback"
)
```

Both attributes are optional and default values can be used instead.

### HapticsKit

When launching your app, configure HapticsKit like so:

```swift
let haptics = HapticsKit.configure(with: configuration)
```

If you do not configure HapticsKit at launch, a default configuration will be used instead. You can then access HapticsKit in the future by referencing the created version as above or:

```swift
HapticsKit.shared
```

On iOS, the following methods can be called to perform haptic feedback:

```swift
HapticsKit.shared.performNotification(.success) // .success, .warning, .error

HapticsKit.shared.performImpact(.medium, at: 1.0) // .light, .medium, .heavy, .soft, .rigid; 0...1

HapticsKit.shared.performSelection()
```

On watchOS, the following method can be called to perform haptic feedback:

```swift
HapticsKit.shared.perform(.click) // .notification, .directionUp, .directionDown, .success, .failure, .retry, .start, .stop, .click
```

When performing haptic feedback, HapticsKit will check whether the user has haptic feedback enabled. The UserDefaults store and key can be configured as part of the configuration. Checking if haptic feedback is enabled can be done like so:

```swift
let enabled = HapticsKit.shared.hapticFeedbackEnabled
```

This value can be added to a SwiftUI Toggle as a binding. To check whether a device supports haptic feedback, you can use the following:

```swift
let deviceSupportsHapticFeedback = HapticsKit.hapticFeedbackSupported
```

## Testing Haptic Feedback

You can use my app [Haptics](https://apps.apple.com/app/id1474606532) to test out the different haptic feedback combinations.

## Other Packages

### [AboutKit](https://github.com/adamfootdev/AboutKit)

Add an about screen to your app.

### [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)

Add a features list screen to your app.

### [HelpKit](https://github.com/adamfootdev/HelpKit)

Add a help screen to your app.

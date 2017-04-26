# HapticGenerator
Easy peasy haptic generation in iOS.

## Usage

Super easy to use. Simply create a new generator like so:

```swift
let selectionHapticGenerator = HapticGenerator(hapticType: .selection)
let lightImpactHapticGenerator = HapticGenerator(hapticType: .impact(.light))
let warningHapticGenerator = HapticGenerator(hapticType: .notification(.warning))
```

And then generate a haptic like so:

```swift
selectionHapticGenerator.generateHaptic()
```

Optionally, you can tell the system to prepare the engine for (re)use like so:

```swift
selectionHapticGenerator.prepareForUse()
```

## Why use this?

Apple's `UIFeedbackGenerator` subclasses are not difficult to use, but they are messy.

`HapticGenerator` tidies this up and makes the process of creating different types of haptics on iOS easy and coherent.

See the difference between creating and using generators of different types Apple's way, and the `HapticGenerator` way:

```swift

// Apple's way of using a selection feedback generator:
let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
// Generate the haptic:
selectionFeedbackGenerator.selectionChanged()

// Apple's way of using an impact feedback generator:
let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
// Generate the haptic:
lightImpactFeedbackGenerator.impactOccurred()

// Apple's way of using a notification feedback generator: 
let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
// Generate the haptic
notificationFeedbackGenerator.notificationOccurred(.success)

// Compare that to the `HapticGenerator` way for all three:
let selectionHapticGenerator = HapticGenerator(hapticType: .selection)
selectionHapticGenerator.generateHaptic()

let lightImpactHapticGenerator = HapticGenerator(hapticType: .impact(.light))
lightImpactHapticGenerator.generateHaptic()

let successNotificationHapticGenerator = HapticGenerator(hapticType: .notification(.success))
successNotificationHapticGenerator.generateHaptic()

```

You can see how `HapticGenerator` works by making the construction of generators more coherent and consistent, leading to easier use.

Furthermore, if you support any iOS version prior to iOS 10, you won't have ugly availability checks throughout your code because it is all contained within `HapticGenerator`. 
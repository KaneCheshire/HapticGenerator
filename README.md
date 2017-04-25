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

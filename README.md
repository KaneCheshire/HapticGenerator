# HapticGenerator
Easy peasy haptic generation in iOS.

[![CI Status](http://img.shields.io/travis/kanecheshire/HapticGenerator.svg?style=flat)](https://travis-ci.org/kanecheshire/HapticGenerator)
[![Version](https://img.shields.io/cocoapods/v/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)
[![License](https://img.shields.io/cocoapods/l/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)
[![Platform](https://img.shields.io/cocoapods/p/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)

## Installation

Add the following to your podfile:

```ruby
pod 'HapticGenerator'
```

Or you can just add `HapticGenerator.swift` to your project manually.

## Usage

HapticGenerator 2.0.0 comes with convenience constants so generating haptics is even easier now:

```swift
HapticGenerator.selection.generateHaptic()
```

Alternatively, if you'd rather create the generators yourself simply create a new generator like so:

```swift
let selectionHapticGenerator = HapticGenerator(hapticType: .selection)
let lightImpactHapticGenerator = HapticGenerator(hapticType: .impact(.light))
let warningHapticGenerator = HapticGenerator(hapticType: .notification(.warning))
```

And then generate a haptic like so:

```swift
selectionHapticGenerator.generateHaptic()
```

Optionally, you can tell the system to prepare the engine for (re)use.
HapticGenerator has two ways to do this, either after you generate a haptic by setting `prepareForReuse` to `true`:

```swift
HapticGenerator.selection.generateHaptic(prepareForReuse: true)
```

Or if you know in advance before generating a haptic that you'll need to use it soon (after a screen appears for example),
then you can `prepareForUse` manually:

```swift
HapticGenerator.selection.prepareForUse()
```

## Why use this?

Apple's `UIFeedbackGenerator` subclasses are not difficult to use, but they _are_ messy.

`HapticGenerator` tidies this up and makes the process of creating different types of haptics on iOS easy and coherent.

See the difference between creating and using generators of different types Apple's way, and the `HapticGenerator` way:

```swift

// Apple's way of using a selection feedback generator:
let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
// Generate the haptic:
selectionFeedbackGenerator.selectionChanged()

// Apple's way of using an impact feedback generator:
let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
lightImpactFeedbackGenerator.impactOccurred()

// Apple's way of using a notification feedback generator:
let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
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

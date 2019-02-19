# HapticGenerator
Easy peasy haptic generation in iOS.

[![CI Status](http://img.shields.io/travis/KaneCheshire/HapticGenerator.svg?style=flat)](https://travis-ci.org/kanecheshire/HapticGenerator)
[![Version](https://img.shields.io/cocoapods/v/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)
[![License](https://img.shields.io/cocoapods/l/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)
[![Platform](https://img.shields.io/cocoapods/p/HapticGenerator.svg?style=flat)](http://cocoapods.org/pods/HapticGenerator)

## Installation

Add the following to your podfile:

```ruby
pod 'HapticGenerator'
```

and then run `pod update` in Terminal.

Or you can just add `HapticGenerator.swift` to your project manually.

## Migrating from HapticGenerator 2 to HapticGenerator 3

**HapticGenerator 3.0.0 significantly simplifies naming, but will be a breaking change requiring you to update your app.**

In **HapticGenerator 3**, the line of code to generate a haptic has been simplified:

```swift
Haptic.selection.generate()
Haptic.selection.generate(prepareForReuse: true)
```

Compared to **HapticGenerator 2** which was a bit too verbose for no real good reason:

```swift
HapticGenerator.selection.generateHaptic()
HapticGenerator.selection.generateHaptic(prepareForReuse: true)
```

## Usage

**HapticGenerator** now comes with convenience constants so generating haptics is even easier:

```swift
Haptic.selection.generate()
```

Alternatively, if you'd rather create the generators yourself simply create a new generator like so:

```swift
let selection = Haptic(.selection)
let lightImpact = Haptic(.impact(.light))
let warning = Haptic(.notification(.warning))
```

And then generate a haptic like so:

```swift
selection.generate()
```

Optionally, you can tell the system to prepare the engine for (re)use.
**HapticGenerator** has two ways to do this, either after you generate a haptic by setting `prepareForReuse` to `true`:

```swift
Haptic.selection.generate(prepareForReuse: true)
```

Or if you know in advance before generating a haptic that you'll need to use it soon (after a screen appears for example),
then you can `prepareForUse` manually:

```swift
Haptic.selection.prepareForUse()
```

**Note:** Haptics should only be generated and prepared for reuse on the main thread.

## Why use this?

Apple's `UIFeedbackGenerator` subclasses are not difficult to use, but they _are_ messy.

**HapticGenerator** tidies this up and makes the process of creating different types of haptics on iOS easy and coherent.

See the difference between creating and using generators of different types Apple's way, and the **HapticGenerator** way:

```swift

// Apple's way of using a selection feedback generator:
let selection = UISelectionFeedbackGenerator()
// Generate the haptic:
selection.selectionChanged()

// Apple's way of using an impact feedback generator:
let lightImpact = UIImpactFeedbackGenerator(style: .light)
lightImpact.impactOccurred()

// Apple's way of using a notification feedback generator:
let success = UINotificationFeedbackGenerator()
success.notificationOccurred(.success)
```

Compared to the **HapticGenerator** way:

```swift
Haptic.selection.generate()

Haptic.lightImpact.generate()

Haptic.success.generate()
```

**HapticGenerator** is significantly less code to write and easier to follow.

Furthermore, if you support any iOS version prior to iOS 10, you won't have ugly availability checks throughout your code because it is all contained within **HapticGenerator**.

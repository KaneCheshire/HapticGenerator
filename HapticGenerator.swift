//
//  HapticGenerator.swift
//  Created by Kane Cheshire on 16/12/2016.
//
import UIKit
import AudioToolbox

/// Generates haptics on supported devices.
/// On devices that don't support haptics, the generator silently fails,
/// so you don't need to check for compatibility or OS version.
///
// MARK: - A struct that encapsulates haptic feedback generation -
public struct Haptic {
    
    // MARK: - Properties -
    // MARK: Static
    
    // Convenience for getting a selection haptic generator
    public static let selection = Haptic(type: .selection)
    
    // Convenience for getting a light impact haptic generator
    public static let impactLight = Haptic(type: .impact(.light))
    // Convenience for getting a medium impact haptic generator
    public static let impactMedium = Haptic(type: .impact(.medium))
    // Convenience for getting a heavy impact haptic generator
    public static let impactHeavy = Haptic(type: .impact(.heavy))
    
    // Convenience for getting an error haptic generator
    public static let error = Haptic(type: .notification(.error))
    // Convenience for getting a warning haptic generator
    public static let warning = Haptic(type: .notification(.warning))
    // Convenience for getting a success haptic generator
    public static let success = Haptic(type: .notification(.success))
    
    // MARK: Internal
    
    let type: HapticType
    internal(set) var generator: Any? = nil
    
    // MARK: - Enums -
    // MARK: Public
    
    /// The type of haptic you want to generate.
    ///
    /// - impact: Configured with an ImpactType, this haptic generates a light, medium or heavy impact feeling to the user.
    /// - selection: Generates a gentle tap to the user indicating a selection has changed.
    /// - notification: Configured with a NotificationType, this haptic generates a warning, error or success feeling to the user.
    public enum HapticType {
        
        case selection
        
        /// The type of impact haptic to generate.
        ///
        /// - light: A light impact is slightly stronger than HapticType.selection.
        /// - medium: A medium impact is slightly stronger than ImpactType.light but weaker than ImpactType.heavy.
        /// - heavy: A heavy impact is stronger than ImpactType.medium.
        public enum ImpactType: Int {
            
            case light
            case medium
            case heavy
            
        }
        
        case impact(ImpactType)
        
        /// The type of notification haptic to generate.
        ///
        /// - error: Indicates an error has occurred to the user.
        /// - success: Indicates an action completed successfully to the user.
        /// - warning: Indicates to the user that a warning has occurred, or that something is about to happen.
        public enum NotificationType: Int {
            
            case error
            case success
            case warning
            
        }
        
        case notification(NotificationType)
    }
    
    // MARK: - Structs -
    // MARK: Private
    
    /// A struct that represents the types of haptic feedback (iPhone 6S/6S Plus only)
    ///
    /// - selectionOrSuccess: A feedback on selection or success notification
    /// - impact: A feedback on impact
    /// - error: A feedback on error
    /// - warn: A feedback on warning
    private struct HapticFeedbackIdentifier {
        static let selection = SystemSoundID(1519)
        static let impact = SystemSoundID(1520)
        static let error = SystemSoundID(1521)
        static let warn = SystemSoundID(1102)
        static let success = SystemSoundID(4095)
    }
    
    // MARK: - Init -
    // MARK: Public
    
    /// Creates a new generator configured with a haptic type.
    ///
    /// - Parameter hapticType: The haptic type this generator is configured with.
    public init(type: HapticType) {
        self.type = type
        if #available(iOS 10.0, *) {
            switch self.type {
            case .selection: self.generator = UISelectionFeedbackGenerator()
            case .impact(let type):
                guard let impactFeedbackStyle = UIImpactFeedbackStyle(rawValue: type.rawValue) else {
                    assertionFailure("Unable to create Apple's feedback style from raw value")
                    return
                }
                self.generator = UIImpactFeedbackGenerator(style: impactFeedbackStyle)
            case .notification: self.generator = UINotificationFeedbackGenerator()
            }
        }
    }
    
    // MARK: - Methods -
    // MARK: Public
    
    /// Generates a haptic.
    /// The type of haptic generates will be determined by the configuration at creation time.
    ///
    /// It is safe to call this function on any version of iOS without checking availability.
    ///
    /// - SeeAlso prepareForUse()
    ///
    /// - Parameter prepareForReuse: If set to `true`, HapticGenerator will attempt to keep the taptic engine powered up for a few seconds, making it more responsive. Defaults to `false`.
    public func generate(prepareForReuse: Bool = false) {
        if #available(iOS 10.0, *), hasTapticEngine() {
            switch type {
            case .selection: (generator as? UISelectionFeedbackGenerator)?.selectionChanged()
            case .impact: (generator as? UIImpactFeedbackGenerator)?.impactOccurred()
            case .notification(let type): (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(UINotificationFeedbackType(rawValue: type.rawValue)!)
            }
            if prepareForReuse {
                prepareForUse()
            }
        } else if hasHapticEngine() {
            switch type {
            case .selection: AudioServicesPlaySystemSound(HapticFeedbackIdentifier.selection)
            case .impact: AudioServicesPlaySystemSound(HapticFeedbackIdentifier.impact)
            case .notification(let type):
                switch(type) {
                case .error: AudioServicesPlaySystemSound(HapticFeedbackIdentifier.error)
                case .success: AudioServicesPlaySystemSound(HapticFeedbackIdentifier.success)
                case .warning: AudioServicesPlaySystemSound(HapticFeedbackIdentifier.warn)
                }
            }
        }
    }
    
    /// Prepares the taptic engine for use by powering it up momentarily.
    /// Call immediately after generating a haptic to keep the taptic engine powered up for
    /// a few seconds to reduce latency. Useful when scrolling through a list or timeline.
    ///
    /// It is safe to call this function on any version of iOS without checking availability.
    ///
    /// - SeeAlso generate(prepareForReuse: Bool)
    public func prepareForUse() {
        if #available(iOS 10.0, *) {
            (generator as? UIFeedbackGenerator)?.prepare()
        }
    }
}

// MARK: - Extension that contains methods to determine current device & supported device(s)
extension Haptic {
    
    // MARK: - Enums -
    // MARK: Internal
    
    /// An enum that represents the type of device (iPhone)
    ///
    /// - iPhone6S: An iPhone 6S
    /// - iPhone6SPlus: An iPhone 6S Plus
    /// - iPhone7: An iPhone 7
    /// - iPhone7Plus: An iPhone 7 Plus
    /// - iPhone8: An iPhone 8
    /// - iPhone8Plus: An iPhone 8 Plus
    /// - iPhoneX: An iPhone X
    /// - unsupported: An unsupported device (iPhone 6 or below)
    internal enum Device: String {
        case iPhone6S
        case iPhone6SPlus
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case unsupported
    }
    
    // MARK: - Methods -
    // MARK: Internal
    
    /// Checks which device (iPhone model) the user has
    ///
    /// - Returns: A `Device` enum value that represents the user's device
    internal func getCurrentDevice() -> Device {
        var sysinfo = utsname()
        uname(&sysinfo)
        guard let model = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) else {
            return .unsupported
        }
        switch model {
        case "iPhone10,3", "iPhone10,6":
            return .iPhoneX
        case "iPhone10,2", "iPhone10,5":
            return .iPhone8Plus
        case "iPhone10,1", "iPhone10,4":
            return .iPhone8
        case "iPhone9,2", "iPhone9,4":
            return .iPhone7Plus
        case "iPhone9,1", "iPhone9,3":
            return .iPhone7
        case "iPhone8,2":
            return .iPhone6SPlus
        case "iPhone8,1":
            return .iPhone6S
        default:
            return .unsupported
        }
    }
    
    /// Checks whether the user's device has the Taptic Engine
    ///
    /// - Returns: `true` if the user's device has the Taptic Engine, `false` otherwise
    internal func hasTapticEngine() -> Bool {
        let supportedDevices = [Device.iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus, .iPhoneX]
        let currentDevice = getCurrentDevice()
        return supportedDevices.contains(currentDevice)
    }
    
    /// Checks whether the user's device has the Haptic Engine
    ///
    /// The devices that have a Taptic Engine can also create Haptic feedback, but we ignore those
    /// devices because we want to use the Taptic Engine on those devices.
    ///
    /// - Returns: `true` if the user's device has the Haptic Engine, `false` otherwise
    internal func hasHapticEngine() -> Bool {
        let supportedDevices = [Device.iPhone6S, .iPhone6SPlus]
        let currentDevice = getCurrentDevice()
        return supportedDevices.contains(currentDevice)
    }
}

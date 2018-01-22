//
//  HapticGenerator.swift
//  Created by Kane Cheshire on 16/12/2016.
//
import UIKit

/// Generates haptics on supported devices.
/// On devices that don't support haptics, the generator silently fails,
/// so you don't need to check for compatibility or OS version.
public struct Haptic {
    
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
    
    let type: HapticType
    internal(set) var generator: Any? = nil
    
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
    
    /// Generates a haptic.
    /// The type of haptic generates will be determined by the configuration at creation time.
    ///
    /// It is safe to call this function on any version of iOS without checking availability.
    ///
    /// - SeeAlso prepareForUse()
    ///
    /// - Parameter prepareForReuse: If set to `true`, HapticGenerator will attempt to keep the taptic engine powered up for a few seconds, making it more responsive. Defaults to `false`.
    public func generate(prepareForReuse: Bool = false) {
        if #available(iOS 10.0, *) {
            switch type {
            case .selection: (generator as? UISelectionFeedbackGenerator)?.selectionChanged()
            case .impact: (generator as? UIImpactFeedbackGenerator)?.impactOccurred()
            case .notification(let type): (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(UINotificationFeedbackType(rawValue: type.rawValue)!)
            }
            if prepareForReuse {
                prepareForUse()
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

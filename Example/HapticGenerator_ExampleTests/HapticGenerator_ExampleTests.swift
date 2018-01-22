import UIKit
import XCTest
@testable import HapticGenerator

class Tests: XCTestCase {
    
    func test_creatingGenerators() {
        switch selectionGenerator.type {
        case .selection: XCTAssertNotNil(selectionGenerator.generator as? UISelectionFeedbackGenerator)
        default: XCTFail("Selection generator has the wrong type")
        }
        
        switch lightImpactGenerator.type {
        case .impact(let type):
            switch type {
            case .light: XCTAssertNotNil(lightImpactGenerator.generator as? UIImpactFeedbackGenerator)
            default: XCTFail("Light impact generator has the wrong type")
            }
        default: XCTFail("Light impact generator has the wrong type")
        }
        
        switch mediumImpactGenerator.type {
        case .impact(let type):
            switch type {
            case .medium: XCTAssertNotNil(mediumImpactGenerator.generator as? UIImpactFeedbackGenerator)
            default: XCTFail("Medium impact generator has the wrong type")
            }
        default: XCTFail("Medium impact generator has the wrong type")
        }
        
        switch heavyImpactGenerator.type {
        case .impact(let type):
            switch type {
            case .heavy: XCTAssertNotNil(heavyImpactGenerator.generator as? UIImpactFeedbackGenerator)
            default: XCTFail("Heavy impact generator has the wrong type")
            }
        default: XCTFail("Heavy impact generator has the wrong type")
        }
        
        switch successNotificationGenerator.type {
        case .notification(let type):
            switch type {
            case .success: XCTAssertNotNil(successNotificationGenerator.generator as? UINotificationFeedbackGenerator)
            default: XCTFail("Success notification generator has the wrong type")
            }
        default: XCTFail("Success notification generator has the wrong type")
        }
        
        switch warningNotificationGenerator.type {
        case .notification(let type):
            switch type {
            case .warning: XCTAssertNotNil(warningNotificationGenerator.generator as? UINotificationFeedbackGenerator)
            default: XCTFail("Warning notification generator has the wrong type")
            }
        default: XCTFail("Warning notification generator has the wrong type")
        }
        
        switch errorNotificationGenerator.type {
        case .notification(let type):
            switch type {
            case .error: XCTAssertNotNil(errorNotificationGenerator.generator as? UINotificationFeedbackGenerator)
            default: XCTFail("Error notification generator has the wrong type")
            }
        default: XCTFail("Error notification generator has the wrong type")
        }
    }
    
}

extension Tests {
    
    var selectionGenerator: Haptic {
        return Haptic(type: .selection)
    }
    
    var lightImpactGenerator: Haptic {
        return Haptic(type: .impact(.light))
    }
    
    var mediumImpactGenerator: Haptic {
        return Haptic(type: .impact(.medium))
    }
    
    var heavyImpactGenerator: Haptic {
        return Haptic(type: .impact(.heavy))
    }
    
    var successNotificationGenerator: Haptic {
        return Haptic(type: .notification(.success))
    }
    
    var warningNotificationGenerator: Haptic {
        return Haptic(type: .notification(.warning))
    }
    
    var errorNotificationGenerator: Haptic {
        return Haptic(type: .notification(.error))
    }
    
}

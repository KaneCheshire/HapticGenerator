import UIKit
import XCTest
@testable import HapticGenerator

class Tests: XCTestCase {
  
  func test_creatingGenerators() {
    switch selectionGenerator.hapticType {
    case .selection: XCTAssertNotNil(selectionGenerator.generator as? UISelectionFeedbackGenerator)
    default: XCTFail("Selection generator has the wrong type")
    }
    
    switch lightImpactGenerator.hapticType {
    case .impact(let type):
      switch type {
      case .light: XCTAssertNotNil(lightImpactGenerator.generator as? UIImpactFeedbackGenerator)
      default: XCTFail("Light impact generator has the wrong type")
      }
    default: XCTFail("Light impact generator has the wrong type")
    }
    
    switch mediumImpactGenerator.hapticType {
    case .impact(let type):
      switch type {
      case .medium: XCTAssertNotNil(mediumImpactGenerator.generator as? UIImpactFeedbackGenerator)
      default: XCTFail("Medium impact generator has the wrong type")
      }
    default: XCTFail("Medium impact generator has the wrong type")
    }
    
    switch heavyImpactGenerator.hapticType {
    case .impact(let type):
      switch type {
      case .heavy: XCTAssertNotNil(heavyImpactGenerator.generator as? UIImpactFeedbackGenerator)
      default: XCTFail("Heavy impact generator has the wrong type")
      }
    default: XCTFail("Heavy impact generator has the wrong type")
    }
    
    switch successNotificationGenerator.hapticType {
    case .notification(let type):
      switch type {
      case .success: XCTAssertNotNil(successNotificationGenerator.generator as? UINotificationFeedbackGenerator)
      default: XCTFail("Success notification generator has the wrong type")
      }
    default: XCTFail("Success notification generator has the wrong type")
    }
    
    switch warningNotificationGenerator.hapticType {
    case .notification(let type):
      switch type {
      case .warning: XCTAssertNotNil(warningNotificationGenerator.generator as? UINotificationFeedbackGenerator)
      default: XCTFail("Warning notification generator has the wrong type")
      }
    default: XCTFail("Warning notification generator has the wrong type")
    }
    
    switch errorNotificationGenerator.hapticType {
    case .notification(let type):
      switch type {
      case .error: XCTAssertNotNil(errorNotificationGenerator.generator as? UINotificationFeedbackGenerator)
      default: XCTFail("Error notification generator has the wrong type")
      }
    default: XCTFail("Error notification generator has the wrong type")
    }
  }
  
}

extension XCTestCase {
  var selectionGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .selection)
  }
  
  var lightImpactGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .impact(.light))
  }
  
  var mediumImpactGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .impact(.medium))
  }
  
  var heavyImpactGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .impact(.heavy))
  }
  
  var successNotificationGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .notification(.success))
  }
  
  var warningNotificationGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .notification(.warning))
  }
  
  var errorNotificationGenerator: HapticGenerator {
    return HapticGenerator(hapticType: .notification(.error))
  }
}

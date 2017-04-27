//
//  ViewController.swift
//  HapticGenerator
//
//  Created by kanecheshire on 04/26/2017.
//  Copyright (c) 2017 kanecheshire. All rights reserved.
//

import UIKit
import HapticGenerator

class ViewController: UIViewController {
  
  let selectionHapticGenerator = HapticGenerator(hapticType: .selection)
  let lightImpactHapticGenerator = HapticGenerator(hapticType: .impact(.light))
  let mediumImpactHapticGenerator = HapticGenerator(hapticType: .impact(.medium))
  let heavyImpactHapticGenerator = HapticGenerator(hapticType: .impact(.heavy))
  let successNotificationHapticGenerator = HapticGenerator(hapticType: .notification(.success))
  let warningNotificationHapticGenerator = HapticGenerator(hapticType: .notification(.warning))
  let errorNotificationHapticGenerator = HapticGenerator(hapticType: .notification(.error))

  @IBAction private func selectionTapped(_ sender: UIButton) {
    // Note that you can run this on pre-iOS 10 without an availability check, it just fails silently.
    selectionHapticGenerator.generateHaptic()
    selectionHapticGenerator.prepareForUse() // Keeps Taptic engine "spun up"
  }

  @IBAction private func lightImpactTapped(_ sender: UIButton) {
    lightImpactHapticGenerator.generateHaptic()
    lightImpactHapticGenerator.prepareForUse()
  }
  
  @IBAction private func mediumImpactTapped(_ sender: UIButton) {
    mediumImpactHapticGenerator.generateHaptic()
    mediumImpactHapticGenerator.prepareForUse()
  }
  
  @IBAction private func heavyImpactTapped(_ sender: UIButton) {
    heavyImpactHapticGenerator.generateHaptic()
    heavyImpactHapticGenerator.prepareForUse()
  }
  
  @IBAction private func successNotificationTapped(_ sender: UIButton) {
    successNotificationHapticGenerator.generateHaptic()
    successNotificationHapticGenerator.prepareForUse()
  }
  
  @IBAction private func warningNotificationTapped(_ sender: UIButton) {
    warningNotificationHapticGenerator.generateHaptic()
    warningNotificationHapticGenerator.prepareForUse()
  }
  
  @IBAction private func errorNotificationTapped(_ sender: UIButton) {
    errorNotificationHapticGenerator.generateHaptic()
    errorNotificationHapticGenerator.prepareForUse()
  }
}


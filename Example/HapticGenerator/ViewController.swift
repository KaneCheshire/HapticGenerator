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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We know we're using the taptic engine soon so let's prepare it
        HapticGenerator.selection.prepareForUse()
    }
    
    @IBAction private func selectionTapped(_ sender: UIButton) {
        // Note that you can run this on pre-iOS 10 without an availability check, it just fails silently.
        HapticGenerator.selection.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func lightImpactTapped(_ sender: UIButton) {
        // We know we're going to be re-using the engine again so set `prepareForReuse` to `true`.
        // The default of this argument is `false` so you can leave this argument out if you don't need it.
        HapticGenerator.impactLight.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func mediumImpactTapped(_ sender: UIButton) {
        HapticGenerator.impactMedium.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func heavyImpactTapped(_ sender: UIButton) {
        HapticGenerator.impactHeavy.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func successNotificationTapped(_ sender: UIButton) {
        HapticGenerator.success.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func warningNotificationTapped(_ sender: UIButton) {
        HapticGenerator.warning.generateHaptic(prepareForReuse: true)
    }
    
    @IBAction private func errorNotificationTapped(_ sender: UIButton) {
        HapticGenerator.error.generateHaptic()
    }
    
}


//
//  SicaViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import Sica
class SicaViewController: UIViewController {
    @IBOutlet weak var sampleView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let toW: CGFloat = (UIScreen.main.bounds.width / 2)
        let toH = (UIScreen.main.bounds.height / 2)
        let duration: Double = 1.5
        let animator = Animator(view: sampleView)
        animator
            .addBasicAnimation(keyPath: .positionX, from: 0, to: toW, duration: duration, timingFunction: .easeOutExpo)
            .addSpringAnimation(keyPath: .boundsSize, from: sampleView.frame.size, to: CGSize(width: 80, height: 80), damping: 20, mass: 1, stiffness: 240, initialVelocity: 0, duration: duration)
            .addBasicAnimation(keyPath: .positionY, from: sampleView.frame.origin.y, to: UIScreen.main.bounds.height, duration: duration, timingFunction: .easeOutExpo)
            .addBasicAnimation(keyPath: .positionY, from: UIScreen.main.bounds.height, to: toH, duration: duration, timingFunction: .easeOutExpo)
            .run(type: .sequence)
    }


}

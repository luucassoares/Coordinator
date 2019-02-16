//
//  SicaViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import Sica
import ViewAnimator
class SicaViewController: UIViewController {

    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func button2tap(_ sender: Any) {
        if indicator.frame.origin.x == 0 {
            self.leadingConstraint.constant = indicator.frame.size.width;
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
        
    }
    @IBAction func button1tap(_ sender: Any) {
        if indicator.frame.origin.x == indicator.frame.size.width {
            self.leadingConstraint.constant = 0;
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
    }
}

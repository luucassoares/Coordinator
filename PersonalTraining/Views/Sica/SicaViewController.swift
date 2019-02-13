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
    @IBOutlet weak var sampleView: UIView!
    @IBOutlet weak var sampleView2: UIView!
    @IBOutlet weak var sampleView3: UIView!
    @IBOutlet weak var sampleView4: UIView!
    @IBOutlet weak var viewVerticalY: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let duration: Double = 1
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.1, options: .curveEaseInOut, animations: {
            self.sampleView.frame.origin.x = self.view.center.x - 50
            self.sampleView2.frame.origin.x = self.view.center.x
            self.sampleView.backgroundColor = .purple
            self.sampleView2.backgroundColor = .brown
            self.sampleView3.frame.origin.y = self.view.center.y
            self.sampleView3.backgroundColor = .gray
            self.sampleView4.frame.origin.y = self.view.center.y + 50
            self.sampleView4.backgroundColor = .red
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
        
        
    }
    

}

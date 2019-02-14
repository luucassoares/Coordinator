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
    @IBOutlet weak var viewVerticalY: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView! // verde
    @IBOutlet weak var leadingView: UIView! //vermelha
    @IBOutlet weak var bottomView: UIView! //amarela
    @IBOutlet weak var trailingView: UIView! //roxa
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let duration: Double = 1
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.1, options: .curveEaseInOut, animations: {
            
            
            
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
        
        
    }
    

}

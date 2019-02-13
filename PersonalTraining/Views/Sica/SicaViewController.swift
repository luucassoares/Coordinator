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
        let size: CGFloat = 100
        let newHeight1: CGFloat = size
        let newWidth1: CGFloat = size
        let newY1 = self.sampleView.frame.origin.y - (newHeight1 / 4.0)
        
        let newHeight2: CGFloat = size
        let newWidth2: CGFloat = size
        let newX2 = self.sampleView2.frame.origin.x - (newHeight2 / 2.0)
        let newY2 = self.sampleView2.frame.origin.y - (newHeight2 / 4.0)
        
        let newHeight3: CGFloat = size
        let newWidth3: CGFloat = size
        let newX3 = self.sampleView3.frame.origin.x - (newHeight3 / 4.0)
        let newY3 = self.sampleView3.frame.origin.y// - (newHeight3 / 2.0)
        
        let newHeight4: CGFloat = size
        let newWidth4: CGFloat = size
        let newX4 = self.sampleView4.frame.origin.x - (newHeight4 / 4.0)
        let newY4 = self.sampleView4.frame.origin.y - (newHeight4 / 2.0)
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            self.sampleView.frame = CGRect(x: self.sampleView.frame.origin.x, y: newY1, width: newWidth1, height: newHeight1)
            self.sampleView2.frame = CGRect(x: newX2, y: newY2, width: newWidth2, height: newHeight2)
            self.sampleView3.frame = CGRect(x: newX3, y: newY3, width: newWidth3, height: newHeight3)
            self.sampleView4.frame = CGRect(x: newX4, y: newY4, width: newWidth4, height: newHeight4)
            self.view.layoutIfNeeded()
        }) { (position) in
            print(position)
        }
        
        
    }
    

}

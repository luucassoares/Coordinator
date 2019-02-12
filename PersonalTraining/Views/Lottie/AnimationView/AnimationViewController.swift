//
//  AnimationViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import Lottie


class AnimationViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var LOTView: UIView!
    @IBOutlet weak var animationLabel: UILabel!
    
    var mTitle = "Testes"
    var animationFile = ""
    
    convenience required init (withTitle: String, animationFile: String) {
        self.init()
        self.mTitle = withTitle
        self.animationFile = animationFile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationLabel.text = mTitle
        bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        let bundle = Bundle.main.path(forResource: "\(animationFile)", ofType: "json")
        let animationView = LOTAnimationView(filePath: bundle ?? "")
        animationView.frame = LOTView.frame
        LOTView.addSubview(animationView)
        animationView.play()
    }

    @IBAction func closeButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

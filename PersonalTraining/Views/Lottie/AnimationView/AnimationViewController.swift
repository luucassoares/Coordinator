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
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    var mTitle: String?
    var animationFile: String?
    
    convenience required init (withTitle: String, animationFile: String) {
        self.init()
        self.mTitle = withTitle
        self.animationFile = animationFile
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        bottomConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.titleLabel.text = self.mTitle
            self.closeButton.setTitle("Fechar", for: .normal)
            let bundle = Bundle.main.path(forResource: "\(self.animationFile ?? "")", ofType: "json")
            let animationView = LOTAnimationView(filePath: bundle ?? "")
            animationView.loopAnimation = true
            let height = UIScreen.main.bounds.height * 0.5
            self.containerViewHeight.constant = height
            animationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
            self.containerView.addSubview(animationView)
            animationView.play()
            self.view.layoutIfNeeded()
        }, completion: { finished in
         
        })

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bottomConstraint.constant = -500
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            print("successfully dismissed animationModal")
        })
    }
    
}

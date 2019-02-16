//
//  SicaViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
class SicaViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var button1: CustomUIButton!
    @IBOutlet weak var button2: CustomUIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    //Custom View
    var indicator: UIView!
    
    //MARK: - Custom vars
    var indicatorConstraints: [(_where: String, constraint: NSLayoutConstraint)] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicator = UIView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .black
        self.view.addSubview(indicator)
        indicator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        indicator.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 0).isActive = true
        indicator.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 0).isActive = true
        indicator.widthAnchor.constraint(equalTo: self.button1.widthAnchor).isActive = true

        
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func button2tap(_ sender: Any) {
        
        if indicator.frame.origin.x == 8 {
            print("Move indicator to button 2")
            indicator.frame.origin.x = button1.frame.width + 16 // 16 = 8 leading da stack + 8 de espaço entre os botoes da stack
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
        
    }
    @IBAction func button1tap(_ sender: Any) {
    
        if Int(indicator.frame.origin.x) == Int(button1.frame.width + 16) {
            print("Move indicator to button 1")
            indicator.frame.origin.x = 8
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
        }) { (position) in
            
        }
    }
}

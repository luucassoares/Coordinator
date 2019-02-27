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
    @IBOutlet weak var button3: CustomUIButton!
    @IBOutlet weak var button4: CustomUIButton!
    @IBOutlet weak var button5: CustomUIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var gradientButton: GradientButton!
    @IBOutlet weak var shapeView: GradientView!
    
    
    //Custom View
    var indicator: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK :- Setup
    func setup () {
        shapeView.backgroundColor = .white
        setupIndicator()
        setupButtons()
    }
    
    func setupButtons() {
        button1.borderColor = Colors.GOLD_GRADIENT_LEFT
        button1.setTitleColor(Colors.GOLD_GRADIENT_RIGHT, for: .normal)
        
        button2.borderColor = Colors.BLUE_GRADIENT_LEFT
        button2.setTitleColor(Colors.BLUE_GRADIENT_RIGHT, for: .normal)
        
        button3.borderColor = Colors.GREEN_GRADIENT_LEFT
        button3.setTitleColor(Colors.GREEN_GRADIENT_RIGHT, for: .normal)
        
        button4.borderColor = Colors.YELLOW_GRADIENT_LEFT
        button4.setTitleColor(Colors.YELLOW_GRADIENT_RIGHT, for: .normal)
        
        button5.borderColor = Colors.RED_GRADIENT_LEFT
        button5.setTitleColor(Colors.RED_GRADIENT_RIGHT, for: .normal)
    }
    
    func setupIndicator() {
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
    @IBAction func button1tap(_ sender: Any) {
        NSLog("Move indicator to button 1")
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin.x = 8
            self.gradientButton.changeGradient(to: .golden)
            self.shapeView.changeGradient(to: .golden)
            self.indicator.backgroundColor = Colors.GOLD_GRADIENT_LEFT
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func button2tap(_ sender: Any) {
        NSLog("Move indicator to button 2")
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin.x = self.button1.frame.width + 16 // 16 = 8 leading da stack + 8 de espaço entre os botoes da stack
            self.gradientButton.changeGradient(to: .blue)
            self.shapeView.changeGradient(to: .blue)
            self.indicator.backgroundColor = Colors.BLUE_GRADIENT_LEFT
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
  
    @IBAction func button3tap(_ sender: Any) {
        NSLog("Move indicator to button 3")

        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin.x = (self.button1.frame.width * 2) + 24
            self.gradientButton.changeGradient(to: .green)
            self.shapeView.changeGradient(to: .green)
            self.indicator.backgroundColor = Colors.GREEN_GRADIENT_LEFT
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @IBAction func button4tap(_ sender: Any) {
        NSLog("Move indicator to button 4")
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin.x = (self.button1.frame.width * 3) + 32
            self.shapeView.changeGradient(to: .yellow)
            self.gradientButton.changeGradient(to: .yellow)
            self.indicator.backgroundColor = Colors.YELLOW_GRADIENT_LEFT
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @IBAction func button5tap(_ sender: Any) {
        NSLog("Move indicator to button 5")
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin.x = (self.button1.frame.width * 4) + 40
            self.shapeView.changeGradient(to: .red)
            self.indicator.backgroundColor = Colors.RED_GRADIENT_LEFT
            self.gradientButton.changeGradient(to: .red)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

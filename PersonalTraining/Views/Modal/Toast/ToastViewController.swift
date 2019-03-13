//
//  ToastViewController.swift
//  PersonalTraining
//
//  Created by Lucas Soares on 13/03/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {

    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var toastText: UILabel!
    
    
    var text: String?

    
    convenience required init( _ text: String?) {
        self.init()
        self.text = text
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1, animations: {
            self.toastView.isHidden = false
        }, completion: nil) 
    }
    
    func changeText(to text: String?) {
        self.text = text
        setupLabel()
    }
    
    private func setup() {
        setupLabel()
        setupToastView()
    }
    
    private func setupLabel() {
        toastText.text = text
        
    }
    
    private func setupToastView() {
        toastView.layer.cornerRadius = 8
    }

}

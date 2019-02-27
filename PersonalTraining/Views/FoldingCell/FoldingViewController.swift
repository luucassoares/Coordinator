//
//  FoldingViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

class FoldingViewController: UIViewController {

    
    //MARK :- Vars
    var viewModel: FoldingViewModel?
    
    convenience required init (viewModel: FoldingViewModel?) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

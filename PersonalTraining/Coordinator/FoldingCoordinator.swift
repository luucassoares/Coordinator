//
//  FoldingCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class FoldingCoordinator: Coordinator {
    var name: String? = "Folding"
    
    var presenter: UINavigationController?
    var viewController: FoldingViewController?
    var viewModel: FoldingViewModel?
    
    func start() {
        NSLog("Initing Folding View Controller")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
        
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = FoldingViewModel()
        }
        viewController = FoldingViewController(viewModel: viewModel)
        viewController?.title = name
    }
    
    required init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    
}

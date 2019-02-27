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
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = FoldingViewModel()
        }
        viewController?.title = name
        viewController = FoldingViewController(viewModel: viewModel)
    }
    
    required init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    
}

//
//  CollapseCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class CollapseCoordinator: Coordinator {
    var name: String? = "Collapsible TableView"
    var presenter: UINavigationController?
    var viewController: CollapseViewController?
    var viewModel: CollapseViewModel?
    var content: [Section] = sectionsData
    required init (presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = CollapseViewModel(with: content)
        }
        viewController = CollapseViewController(withVm: viewModel)
        viewController?.title = name
    }
    
    func start() {
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
}

//
//  ChartsCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 19/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

enum ChartType: String {
    case LINE = "line"
    case BARS = "barras"
}

class ChartsCoordinator: Coordinator {
    var name: String? = "Charts"
    
    var presenter: UINavigationController?
    var viewController: ChartsViewController?
    var viewModel: ChartsViewModel?
    var options: [ChartType]?
    
    func start() {
        print("Starting Charts ViewController")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = ChartsViewModel(with: options ?? [])
        }
        viewController = ChartsViewController(withViewModel: viewModel)
        viewController?.delegate = self
        viewController?.title = name
    }
    
    func setupOptions() {
        if options == nil {
            options = [ChartType]()
            options?.append(.LINE)
            options?.append(.BARS)
        }
    }
    
    required init(presenter: UINavigationController?) {
        self.presenter = presenter
        setupOptions()
    }
    
    
}

extension ChartsCoordinator: ChartsViewControllerDelegate {
    func didTapAt(charType: ChartType) {
        viewController?.showModal(viewController: ChartContentViewController(chartType: charType))
    }
}

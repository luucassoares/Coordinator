//
//  RootCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit


class RootCoordinator: Coordinator {
    
    private var window: UIWindow
    var presenter: UINavigationController?
    private var options: [String] = []
    var childCoordinators: [Coordinator]? = []
    var viewModel: OptionsViewModel?
    var viewController: OptionsViewController?
    var name: String? = "Root"
    
    init( window: UIWindow ) {
        self.window = window
        presenter = UINavigationController()
        setupChildCoords()
    }
    
    required init(presenter: UINavigationController?) {
        self.presenter = presenter
        self.presenter?.navigationBar.prefersLargeTitles = true
        self.options.append(contentsOf: [""])
        self.window = UIWindow()
    }
    
    //create the options to go from this screen
    private func setupChildCoords() {
        let childC: [Coordinator] = [LottieCoordinator(presenter: presenter),
                                     RxCoordinator(presenter: presenter),
                                     CollapseCoordinator(presenter: presenter),
                                     SicaCoordinator(presenter: presenter),
                                     ViewCodeCoordinator(presenter: presenter)]
//                                     UberCoordinator(presenter: presenter)]
        childCoordinators?.append(contentsOf: childC)
        for child in childCoordinators ?? []{
            self.options.append(child.name ?? "")
        }
        
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = OptionsViewModel(withOptions: options)
        }
        viewController = OptionsViewController(withViewModel: viewModel!)
        viewController?.title = "Options"
        viewController?.setupBack()
        viewController?.delegate = self
    }
    
 
    
    func start() {
        print("Starting Root Coordinator")
        setupViewModelAndViewController()
        presenter!.pushViewController(viewController!, animated: true)
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    private func getChildCoordinator(at index: Int) -> Coordinator? {
        return childCoordinators?[index]
    }
}

extension RootCoordinator: OptionsViewControllerDelegate {
    func didTapOption(at index: Int) {
      getChildCoordinator(at: index)?.start()
    }
}

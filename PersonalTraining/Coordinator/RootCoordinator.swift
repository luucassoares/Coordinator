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
    var name: String? = "Root"
    private var window: UIWindow
    var presenter: UINavigationController?
    private var options: [String] = []
    var childCoordinators: [Coordinator]? = []
    var viewModel: OptionsViewModel?
    var viewController: OptionsViewController?
    
    init( window: UIWindow ) {
        self.window = window
        presenter = UINavigationController()
        presenter!.navigationBar.prefersLargeTitles = true
        setupChildCoords()
    }
    
    private func setupChildCoords() {
        let childC: [Coordinator] = [LottieCoordinator(presenter: presenter!),
                                     RxCoordinator(presenter: presenter!),
                                     CollapseCoordinator(presenter: presenter!)]
        childCoordinators?.append(contentsOf: childC)
        for child in childCoordinators ?? []{
            self.options.append(child.name ?? "noname")
        }
    }
    
    private func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = OptionsViewModel(withOptions: options)
        }
        viewController = OptionsViewController(withViewModel: viewModel!)
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

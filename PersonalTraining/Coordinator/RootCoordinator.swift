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
    private let rootViewController: UINavigationController
    private var options: [String] = []
    private var childCoordinators: [Coordinator] = []
    
    init( window: UIWindow ) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        childCoordinators.append(LottieCoordinator(presenter: rootViewController))
        for child in childCoordinators {
            self.options.append(child.name ?? "noname")
        }
    }
    
    func start() {
        print("Starting Root Coordinator")
        let viewModel = OptionsViewModel(withOptions: options)
        let viewController = OptionsViewController(withViewModel: viewModel)
        viewController.delegate = self
        rootViewController.pushViewController(viewController, animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    private func getChildCoordinator(at index: Int) -> Coordinator? {
        return childCoordinators[index]
    }
}

extension RootCoordinator: OptionsViewControllerDelegate {
    func didTapOption(at index: Int) {
      getChildCoordinator(at: index)?.start()
    }
}

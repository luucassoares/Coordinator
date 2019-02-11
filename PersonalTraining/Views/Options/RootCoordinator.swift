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
    
    init( window: UIWindow ) {
        self.window = window
        presenter = UINavigationController()
        presenter!.navigationBar.prefersLargeTitles = true
        childCoordinators?.append(LottieCoordinator(presenter: presenter!))
        for child in childCoordinators ?? []{
            self.options.append(child.name ?? "noname")
        }
    }
    
    func start() {
        print("Starting Root Coordinator")
        let viewModel = OptionsViewModel(withOptions: options)
        let viewController = OptionsViewController(withViewModel: viewModel)
        viewController.delegate = self
        presenter!.pushViewController(viewController, animated: true)
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

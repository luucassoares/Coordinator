//
//  ViewCodeCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 13/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class ViewCodeCoordinator: Coordinator {
    var name: String? = "View Code"
    var presenter: UINavigationController?
    var viewController: ViewCodeViewController?
    
    func start() {
        print("Starting ViewCodeViewController")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
    func setupViewModelAndViewController() {
        viewController = ViewCodeViewController()
        viewController?.title = name
    }
    

    required init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
}

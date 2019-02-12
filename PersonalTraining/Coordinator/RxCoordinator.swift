//
//  RxCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class RxCoordinator: Coordinator {
    var name: String? = "Rx"
    var presenter: UINavigationController?
    var viewController: RxOptionViewController?
    
    init ( presenter: UINavigationController? ) {
        self.presenter = presenter
        
    }
    
    func setupViewModelAndViewController() {
        viewController = RxOptionViewController()
        viewController?.title = name
    }
    
    func start() {
        print("Starting Rx Coordinator")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
}

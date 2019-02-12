//
//  SicaCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class SicaCoordinator: Coordinator {
    var name: String? = "Sica"
    var presenter: UINavigationController?
    var viewController: SicaViewController?
    
    init( presenter: UINavigationController? ) {
        self.presenter = presenter
    }
    
    func setupViewModelAndViewController() {
        viewController = SicaViewController()
        viewController?.title = name
    }
    
    func start() {
        print("Initing Sica Coordinator")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
    
}

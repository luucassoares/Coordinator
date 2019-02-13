//
//  Coordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit
protocol Coordinator {
    var name: String? { get set }
    var presenter: UINavigationController? { get set }
    func start()
    func setupViewModelAndViewController()
}

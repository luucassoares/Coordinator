//
//  Coordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit
@objc protocol Coordinator {
    var name: String? { get set }
    var presenter: UINavigationController? { get set }
    @objc optional func startModal(withContentIndex index: Int)
    func start()
    
}

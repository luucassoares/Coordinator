//
//  UberCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit
import UberSignature

class UberCoordinator: Coordinator {
    var name: String? = "Uber Signature"
    var viewController: SignatureDrawingViewController?
    var presenter: UINavigationController?
    
    init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    func createVMandVC() {
        viewController = SignatureDrawingViewController(image: UIImage(named: "selfie"))
        viewController?.title = name
    }
    
    func start() {
        print("Initing UberSignature Coordinator")
        createVMandVC()
        presenter?.pushViewController(viewController!, animated: true)
    }
    
}

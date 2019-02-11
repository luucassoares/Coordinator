//
//  LottieCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

class LottieCoordinator: Coordinator {
    var name: String? = "Lottie Animations"
    var presenter: UINavigationController?
    var viewModel: LottieViewModel?
    var viewController: LottieViewController?
    var collectionContent: [(icon: String, title: String)] = []
    
    init( presenter: UINavigationController? ) {
        self.presenter = presenter
        collectionContent.append(("selfie", "Selfie"))
        collectionContent.append(("keys", "Chave"))
        collectionContent.append(("location", "Localização"))
    }
    
    func start() {
        print("Starting Lottie Animation Coordinator")
        viewModel = LottieViewModel(collectionContent: collectionContent)
        viewController = LottieViewController(withViewModel: viewModel!)
        viewController?.title = name
        presenter?.pushViewController(viewController!, animated: true)
    }
    
    
}

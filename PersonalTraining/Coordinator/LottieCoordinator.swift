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
    private var viewModel: LottieViewModel?
    private var viewController: LottieViewController?
    private var collectionContent: [(icon: String, title: String)] = []
    
    
    required init( presenter: UINavigationController? ) {
        self.presenter = presenter
        setupCollectionContent()
        
    }
    
    private func setupCollectionContent() {
        collectionContent.append(("selfie", "Selfie"))
        collectionContent.append(("keys", "Chave"))
        collectionContent.append(("location", "Localização"))
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = LottieViewModel(collectionContent: collectionContent)
        }
        viewController = LottieViewController(withViewModel: viewModel!)
        viewController?.title = name
        viewController?.delegate = self
    }
    
    
    func start() {
        print("Starting Lottie Animation Coordinator")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
    }
    

}

extension LottieCoordinator: LottieViewControllerDelegate {
    func didTapAnimation(at index: Int) {
        let element = collectionContent[index]
        let vc = AnimationViewController(withTitle: element.title, animationFile: element.icon)
        viewController?.showModal(viewController: vc)
    }
}

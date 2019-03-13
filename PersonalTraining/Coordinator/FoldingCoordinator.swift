//
//  FoldingCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

protocol FoldingCoordinatorDelegate {
    func showModal(text: String?)
}

class FoldingCoordinator: Coordinator {
    var name: String? = "Toast"
    var presenter: UINavigationController?
    var viewController: FoldingViewController?
    var toastVc: ToastViewController?
    var viewModel: FoldingViewModel?
    var timer: Timer?
    var timeLeft: Int = 3
    
    var delegate: FoldingCoordinatorDelegate?
    
    func start() {
        NSLog("Initing Folding View Controller")
        setupViewModelAndViewController()
        presenter?.pushViewController(viewController!, animated: true)
        
    }
    
    func setupViewModelAndViewController() {
        if viewModel == nil {
            viewModel = FoldingViewModel()
        }
        viewController = FoldingViewController(viewModel: viewModel)
        viewController?.delegate = self
        viewController?.title = name
    }
    
    required init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    @objc private func timerFired() {
        if timeLeft > 0 {
            timeLeft = timeLeft - 1
            NSLog("Remaining Toast Time: %i", timeLeft)
        } else {
            NSLog("Toast Finished")
            timer?.invalidate()
            toastVc?.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension FoldingCoordinator: FoldingViewControllerDelegate {
    func showToast(withText text: String?) {
        if toastVc == nil {
            toastVc = ToastViewController(text)
        } else {
            toastVc?.changeText(to: text)
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
            
        }
        viewController?.showModal(viewController: toastVc!)
    }
}

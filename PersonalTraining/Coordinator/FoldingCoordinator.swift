//
//  FoldingCoordinator.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import UIKit

enum ToastLength: Int {
    case short = 3
    case medium = 5
    case long = 7
}


class FoldingCoordinator: Coordinator {
    var name: String? = "Toast"
    var presenter: UINavigationController?
    var viewController: FoldingViewController?
    
    var viewModel: FoldingViewModel?
    var timer: Timer? {
        didSet {
            NSLog("Timer was set to nil: \(timer == nil)")
        }
    }
    var timeLeft: Int?
    
    
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
        guard var mTimeLeft = timeLeft else {
            assertionFailure("timeLeft is nil, please set an duration time in seconds for Toast")
            return
        }
        if mTimeLeft > 0 {
            mTimeLeft = mTimeLeft - 1
            timeLeft = mTimeLeft
            NSLog("Remaining Toast Time: %i", mTimeLeft)
        } else {
            NSLog("Toast Finished")
            timer?.invalidate()
            timer = nil
            timeLeft = nil
//            toastVc?.dismiss(animated: true, completion: nil)
            self.viewController?.toast.isHidden = true
        }
        
    }
}

extension FoldingCoordinator: FoldingViewControllerDelegate {
    func showToast(withText text: String?, toastLength: ToastLength) {
        timeLeft = toastLength.rawValue
        viewController?.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.viewController?.hideLoader()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: true)
            self.viewController?.showToast(text: text)
        })
        
    }
}

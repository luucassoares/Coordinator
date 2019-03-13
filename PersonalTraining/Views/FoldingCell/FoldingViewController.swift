//
//  FoldingViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol FoldingViewControllerDelegate {
    func showToast(withText text: String?, toastLength: ToastLength)
}

class FoldingViewController: UIViewController {
    @IBOutlet weak var newToastMessage: NewTextField!
    @IBOutlet weak var makeToastBtn: CustomUIButton!
    
    //MARK :- Vars
    var viewModel: FoldingViewModel?
    var delegate: FoldingViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    convenience required init (viewModel: FoldingViewModel?) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnObservable()
    }
    
    func setupBtnObservable() {
        makeToastBtn.rx.tap.subscribe(onNext: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                guard let text = self.newToastMessage.text, text != "" else {
                    NSLog("Impossible to retrieve textfield text")
                    self.delegate?.showToast(withText: "Impossible to retrieve textfield text", toastLength: .short)
                    return
                }
                self.delegate?.showToast(withText: text, toastLength: .long)
            })
        }).disposed(by: disposeBag)
    }
 
}

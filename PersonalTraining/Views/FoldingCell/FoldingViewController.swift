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
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var newToastMessage: NewTextField!
    @IBOutlet weak var makeToastBtn: CustomUIButton!
    
    //MARK :- Vars
    var viewModel: FoldingViewModel?
    var delegate: FoldingViewControllerDelegate?
    let disposeBag = DisposeBag()
    var toastLength: ToastLength! {
        didSet {
            NSLog("toastLength was setted to: \(toastLength)")
        }
    }
    
    convenience required init (viewModel: FoldingViewModel?) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupBtnObservable()
        setupDismissKeyboard()
    }
    
    private func setupSegmentedControl() {
        segmentedControll.removeAllSegments()
        segmentedControll.insertSegment(withTitle: "Short - \(ToastLength.short.rawValue)s", at: 0, animated: true)
        segmentedControll.insertSegment(withTitle: "Medium - \(ToastLength.medium.rawValue)s", at: 1, animated: true)
        segmentedControll.insertSegment(withTitle: "Long - \(ToastLength.long.rawValue)s", at: 2, animated: true)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.addTarget(self, action: #selector(segmentedControlValueChanged(segmentedControl:)), for: .valueChanged)
    }
    
    
    @objc private func segmentedControlValueChanged(segmentedControl: UISegmentedControl) {
        switch (segmentedControll.selectedSegmentIndex) {
        case 0:
            toastLength = .short
        case 1:
            toastLength = .medium
        case 2:
            toastLength = .long
        default:
            NSLog("Default case on setToastLength")
        }
    }
    
    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing(tap:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func endEditing(tap: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    private func setupBtnObservable() {

        
        makeToastBtn.rx.tap.subscribe(onNext: {
            
            guard let text = self.newToastMessage.text, text != "" else {
                NSLog("Impossible to retrieve textfield text")
                self.delegate?.showToast(withText: "Impossible to retrieve textfield text", toastLength: self.toastLength)
                return
            }
            self.delegate?.showToast(withText: text, toastLength: self.toastLength)
        }).disposed(by: disposeBag)
    }
 
}

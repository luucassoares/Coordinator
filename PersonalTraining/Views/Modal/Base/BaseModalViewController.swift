//
//  BaseModalViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 27/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

protocol BaseModalViewControllerDelegate: class {
    func didTapPositiveButton(modal: BaseModalViewController)
    func didTapNegativeButton(modal: BaseModalViewController)
}

class BaseModalViewController: UIViewController {
    
    //MARK :- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var negativeButton: CustomUIButton!
    @IBOutlet weak var positiveButton: GradientButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //MARK :- Vars
    var modalTitle: String?
    var modalMessage: String?
    var positiveButtonTitle: String?
    var negativeButtonTitle: String?
    
    //MARK :- Delegate var
    var delegate: BaseModalViewControllerDelegate?
    

    //MARK :- Init
    convenience required init (modalTitle: String?, modalMessage: String?, pMessage: String?, nMessage: String?) {
        self.init()
        self.modalTitle = modalTitle
        self.modalMessage = modalMessage
        self.positiveButtonTitle = pMessage
        self.negativeButtonTitle = nMessage
    }
    
    //MARK :- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        positiveButton.gradientType = .golden
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShow(toConstant: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animateShow(toConstant: -200.0)
    }
    
    //MARK :- Setup
    private func setup() {
        positiveButton.isHidden = positiveButtonTitle == nil ? true : false
        negativeButton.isHidden = negativeButtonTitle == nil ? true : false
        positiveButton.setTitle(positiveButtonTitle, for: .normal)
        negativeButton.setTitle(negativeButtonTitle, for: .normal)
        titleLabel.text = modalTitle
        messageLabel.text = modalMessage
    }
    
    //MARK :- Edit constraint
    private func animateShow(toConstant: CGFloat) {
        bottomConstraint.constant = toConstant
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK :- Actions
    @IBAction func negativeButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didTapNegativeButton(modal: self)
        }
    }
    @IBAction func positiveButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didTapPositiveButton(modal: self)
        }
    }
}

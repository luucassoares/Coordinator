//
//  ExtensionUIViewController.swift
//  PersonalTraining
//
//  Created by Lucas Soares on 16/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//
import UIKit
import NVActivityIndicatorView

private var loaderViewAssociationKey: NVActivityIndicatorView?
extension UIViewController {
    
    var loaderView: NVActivityIndicatorView! {
        get { return objc_getAssociatedObject(self, &loaderViewAssociationKey) as? NVActivityIndicatorView }
        set(newValue) { objc_setAssociatedObject(self, &loaderViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    func setupAutoScrollWhenKeyboardShowsUp() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        addObservers()
    }
    
    // OVERRIDE IT!
    @objc func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        
    }
    
    func showModal(viewController controller: UIViewController) {
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
    func showLoader() {
        
        if(loaderView == nil) {
            loaderView = NVActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.size.width/2) - 15, y: UIScreen.main.bounds.size.height/2, width: 35, height: 35) , type: NVActivityIndicatorType.circleStrokeSpin, color: Colors.MAIN_COLOR, padding: 0)
        }
        
        self.lockView(self.view)
        
        if(loaderView.isAnimating == false){
            loaderView.startAnimating()
        }
        
        if self.navigationController ==  nil {
            self.view.addSubview(loaderView)
        }
        else {
            self.navigationController?.view.addSubview(loaderView)
        }
        
    }
    
    func hideLoader () {
        if(loaderView != nil){
            self.unlockView(self.view)
            loaderView.stopAnimating()
            loaderView.removeFromSuperview()
        }
    }
    
    func lockView(_ view: UIView){
        view.isUserInteractionEnabled = false
    }
    
    func unlockView(_ view: UIView) {
        view.isUserInteractionEnabled = true
    }
    func setupBack() {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
    }
    
}

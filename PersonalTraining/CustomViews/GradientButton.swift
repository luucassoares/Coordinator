//
//  GradientButton.swift
//  Mobile2you
//
//  Created by Lucas Soares on 14/01/19.
//  Copyright © 2019 Mobile2You. All rights reserved.
//

import UIKit

enum GradientType {
    case golden
    case blue
}

class GradientButton: UIButton {
    
    var gradientType: GradientType = .golden
    
    override func draw(_ rect: CGRect) {
        
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        
        let gradientLayer = CAGradientLayer()
        
        let alpha: Float = 90 / 360
        let startPointX = powf(sinf(2 * Float.pi * ((alpha + 0.75) / 2)), 2)
        let startPointY = powf(sinf(2 * Float.pi * ((alpha + 0) / 2)), 2)
        let endPointX = powf(sinf(2 * Float.pi * ((alpha + 0.25) / 2)), 2)
        let endPointY = powf(sinf(2 * Float.pi * ((alpha + 0.5) / 2)), 2)
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(endPointX),y: CGFloat(endPointY))
        gradientLayer.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        
        gradientLayer.frame = bounds
        
        switch gradientType {
        case .golden:
            gradientLayer.colors = [Colors.GOLD_GRADIENT_LEFT.cgColor, Colors.GOLD_GRADIENT_RIGHT.cgColor]
        case .blue:
            gradientLayer.colors = [Colors.BLUE_GRADIENT_LEFT.cgColor, Colors.BLUE_GRADIENT_RIGHT.cgColor]
        }
        
        gradientLayer.borderColor = layer.borderColor
        gradientLayer.borderWidth = layer.borderWidth
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    // MARK: - Loader
    // https://stackoverflow.com/questions/36539650/display-activity-indicator-inside-uibutton
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

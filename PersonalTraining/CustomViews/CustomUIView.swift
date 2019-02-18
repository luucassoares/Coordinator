//
//  CustomUIView.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 18/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

enum ViewFormat {
    case REGULAR
    case TRIANGULAR
}

class GradientView: UIView {
    
    var gradientType: GradientType = .golden
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        changeGradient()
    }
    
    func changeGradient(to gradientType: GradientType = .golden) {
        self.gradientType = gradientType
        
        var sublayers = layer.sublayers ?? []
        sublayers.removeAll(where: { (layer) -> Bool in
            if layer is CAGradientLayer {
                return true
            } else {
                return false
            }
        })
        
        layer.cornerRadius = 8
        layer.masksToBounds = false
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(0),y: CGFloat(0))
        gradientLayer.startPoint = CGPoint(x: CGFloat(1), y: CGFloat(1))
        
        gradientLayer.frame = bounds
        
        switch gradientType {
        case .golden:
            gradientLayer.colors = [Colors.GOLD_GRADIENT_LEFT.cgColor, Colors.GOLD_GRADIENT_RIGHT.cgColor]
        case .blue:
            gradientLayer.colors = [Colors.BLUE_GRADIENT_LEFT.cgColor, Colors.BLUE_GRADIENT_RIGHT.cgColor]
        case .green:
            gradientLayer.colors = [Colors.GREEN_GRADIENT_LEFT.cgColor, Colors.GREEN_GRADIENT_RIGHT.cgColor]
        case .yellow:
            gradientLayer.colors = [Colors.YELLOW_GRADIENT_LEFT.cgColor, Colors.YELLOW_GRADIENT_RIGHT.cgColor]
        case .red:
            gradientLayer.colors = [Colors.RED_GRADIENT_LEFT.cgColor, Colors.RED_GRADIENT_RIGHT.cgColor]
        }
        sublayers.insert(gradientLayer, at: 0)
        layer.sublayers = sublayers
    }
}

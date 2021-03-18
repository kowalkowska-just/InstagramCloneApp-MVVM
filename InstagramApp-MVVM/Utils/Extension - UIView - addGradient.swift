//
//  Extension - UIView - addGradient.swift
//  InstagramApp-MVVM
//
//  Created by Justyna Kowalkowska on 18/03/2021.
//

import UIKit

enum Direction: Int {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
}

extension UIView {
    func addGradientWithColors(_ firstColor: UIColor, _ secondColor: UIColor, direction: Direction, locations: [NSNumber]? = [0.0, 1.0]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = locations
        
        switch direction {
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
            
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        self.layer.addSublayer(gradient)
    }
}

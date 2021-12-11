//
//  UIViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import UIKit


extension UIView {
    func createGradient(firstColor: UIColor, secondColor: UIColor, startPoint: CGPoint, endPoint: CGPoint, isAnimated: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [ firstColor.cgColor, secondColor.cgColor]
//        gradientLayer.locations = [0.3, 1]  чекнуть
//        if isAnimated {
//            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
//            gradientChangeAnimation.duration = 5.0
//            gradientChangeAnimation.toValue = [ UIColor..cgColor, UIColor..cgColor ]
//            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
//            gradientChangeAnimation.isRemovedOnCompletion = false
//            gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
//        } // разобрать
        layer.addSublayer(gradientLayer)
    }
}

//
//  UILabelExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 14.12.2021.
//

import Foundation
import UIKit

extension UILabel {
    func makeShadowForText() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0.1)
    }
    
}

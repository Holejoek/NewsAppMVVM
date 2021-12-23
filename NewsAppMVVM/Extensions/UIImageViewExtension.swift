//
//  UIImageViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 18.12.2021.
//

import Foundation
import UIKit


extension UIImageView {
    convenience init(image: UIImage, cornerRadius: CGFloat, contentMode: UIView.ContentMode ) {
        self.init()
        self.image = image
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

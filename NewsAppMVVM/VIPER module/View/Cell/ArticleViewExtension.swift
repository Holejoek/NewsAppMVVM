//
//  ArticleViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 18.12.2021.
//

import Foundation
import UIKit

extension ArticleCell {
   
    
    func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        articleImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30).isActive = true
        articleImage.widthAnchor.constraint(equalTo: articleImage.heightAnchor, constant: 0).isActive = true
        
        
        author.translatesAutoresizingMaskIntoConstraints = false
        author.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10).isActive = true
        author.topAnchor.constraint(equalTo: articleImage.topAnchor, constant: 0).isActive = true
        author.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10).isActive
        = true
        title.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        
        publishedAt.adjustsFontSizeToFitWidth = true
        publishedAt.translatesAutoresizingMaskIntoConstraints = false
        publishedAt.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        publishedAt.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10).isActive = true
        publishedAt.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
       
    }
    }
    

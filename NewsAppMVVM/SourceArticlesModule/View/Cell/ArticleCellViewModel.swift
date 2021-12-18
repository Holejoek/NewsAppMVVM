//
//  ArticleCellViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 15.12.2021.
//

import Foundation

protocol ArticleCellViewModelProtocol {
    var associatedClass: ArticleCellProtocol.Type { get set }
}

struct ArticleCellViewModel: ArticleCellViewModelProtocol {
    var associatedClass: ArticleCellProtocol.Type = ArticleCell.self
    
    let title: String?
    let author: String?
    let publishedAt: String?
    let imageURL: String?
}

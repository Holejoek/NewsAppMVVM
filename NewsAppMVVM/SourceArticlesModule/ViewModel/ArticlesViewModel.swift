//
//  ArticlesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation

//MARK: Input
protocol ArticlesViewModelProtocol: AnyObject {
    init(view: ArticlesViewProtocol, networkService: NetworkServiceProtocol)
    
}
//MARK: Output
protocol ArticlesViewProtocol: AnyObject {
    
}
class ArticlesViewModel: ArticlesViewModelProtocol {
    required init(view: ArticlesViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
   
    var networkService: NetworkServiceProtocol!
    weak var view: ArticlesViewProtocol!
}

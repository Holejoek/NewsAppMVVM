//
//  ArticlesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import CoreGraphics

//MARK: Input
protocol ArticlesViewModelProtocol: AnyObject {
    init(view: ArticlesViewProtocol, networkService: NetworkServiceProtocol, inputSource: Source)
    //input tableView
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol
    func getNumberOfRows(inSection: Int) -> Int
    func getHeightOfRow(forIndexPath: IndexPath) -> CGFloat
    
    // networkService
    func getArticlesFromSourceId()
    
}
//MARK: Output
protocol ArticlesViewProtocol: AnyObject {
    func updateCells()
    func showError()
}


class ArticlesViewModel: ArticlesViewModelProtocol {
    required init(view: ArticlesViewProtocol, networkService: NetworkServiceProtocol, inputSource: Source) {
        self.view = view
        self.networkService = networkService
        self.inputSource = inputSource
    }
    
    var networkService: NetworkServiceProtocol!
    weak var view: ArticlesViewProtocol!
    
    let inputSource: Source!
    var loadedArticles = [Article]()
    
    //MARK: - input TableView
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        let article = loadedArticles[indexPath.row]
        return ArticleCellViewModel(title: article.title, author: article.author, publishedAt: article.publishedAt, imageURL: article.urlToImage)
    }
    
    func getNumberOfRows(inSection: Int) -> Int {
        return loadedArticles.count
    }
    
    func getHeightOfRow(forIndexPath: IndexPath) -> CGFloat {
        return 200
    }
    //MARK: - NetworkService
    func getArticlesFromSourceId() {
        networkService.getSourceArticles(sourceId: inputSource.id) { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .success(let articles):
                guard let articles = articles else {
                    return
                }
                self?.loadedArticles = articles.articles
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.view.updateCells()
            }
        }
    }
    
}

//
//  ArticlePresenter.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 27.12.2021.
//

import Foundation

protocol ArticlePresenterProtocol: AnyObject {
    var router: ArticleRouterProtocol! { get set }
    var interactor: ArticleInteractorProtocol! { get set }
    
    func viewDidLoad()
    
    func getNuberOfRows(forSection: Int) -> Int
    func getTitle() -> String
    func getHeightOfRow(forIndexPath: IndexPath) -> Double
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol
    
}

class ArticlePresenter: ArticlePresenterProtocol {
    
    var router: ArticleRouterProtocol!
    var interactor: ArticleInteractorProtocol!
    weak var view: ArticlesViewProtocol!
    required init(view: ArticlesViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.getArticlesFromSourceId()
    }
    
    func getNuberOfRows(forSection: Int) -> Int {
        self.interactor.outputArticles.count
    }
    
    func getTitle() -> String {
        interactor.inputSource.name
    }
    
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        view.updating(activityIndicator: true)
        let article = interactor.getArticleForRowAt(indexPath: indexPath)
        return ArticleCellViewModel(title: article.title, author: article.author, publishedAt: article.convertedDate, imageURL: article.urlToImage)
        view.updateCells()
    }

    func getHeightOfRow(forIndexPath: IndexPath) -> Double {
        return 200
    }
    
}

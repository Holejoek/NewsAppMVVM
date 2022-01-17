//
//  ArticlesProtocols.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 28.12.2021.
//

import Foundation

protocol ArticlesViewProtocol: AnyObject {
    var presenter: ArticlePresenterProtocol! { get set }
    
    func updateCells()
    func showError(with: Error)
    func showActivityIndicator(isActive: Bool)
}

protocol ArticleInteractorProtocol: AnyObject {
    
    var inputSource: Source! { get set }
    var outputArticles: Box<[Article]> { get set }
    
    var networkService: NetworkServiceProtocol! { get set }
    
    func getArticlesFromSourceId()
    func getArticleForRowAt(indexPath: IndexPath) -> Article
    func getArticlesFromSearchText(text: String)
}

protocol ArticlePresenterProtocol: AnyObject {
    var router: ArticleRouterProtocol! { get set }
    var interactor: ArticleInteractorProtocol! { get set }
    
    func notifyThatViewDidLoad()
    
    func getNumberOfRows(forSection: Int) -> Int
    func getTitle() -> String
    func getHeightOfRow(forIndexPath: IndexPath) -> Double
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol
    func didSelectRowAt(indexPath: IndexPath)
    func getArticlesFromSearchText(text: String)
}

protocol ArticleRouterProtocol: AnyObject {
    func goToDetailArticleModule(inputArticle: Article, inputSource: Source, animated: Bool)
}

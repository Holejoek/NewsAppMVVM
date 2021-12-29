//
//  ArticlePresenter.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 27.12.2021.
//

import Foundation

class ArticlePresenter: ArticlePresenterProtocol {
    
    var router: ArticleRouterProtocol!
    var interactor: ArticleInteractorProtocol!
    weak var view: ArticlesViewProtocol!
    required init(view: ArticlesViewProtocol) {
        self.view = view
    }
    
    func notifyViewDidLoad() {
        DispatchQueue.main.async {
            self.view.showActivityIndicator(isActive: true)
        }
        interactor.getArticlesFromSourceId()
        interactor.outputArticles.bind { [weak self] _ in
            self?.view.updateCells()
        }
    }
    
    func getNumberOfRows(forSection: Int) -> Int {
        interactor.outputArticles.value.count
    }
    
    func getTitle() -> String {
        interactor.inputSource.name
    }

    func getHeightOfRow(forIndexPath: IndexPath) -> Double {
        return 200
    }
    
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        let article = interactor.getArticleForRowAt(indexPath: indexPath)
        return ArticleCellViewModel(title: article.title, author: article.author, publishedAt: article.convertedDate, imageURL: article.urlToImage)
        view.updateCells()
    }
    
    func didSelectRowAt(indexPath: IndexPath){
        
        let article = interactor.outputArticles.value[indexPath.row]
        guard let source = interactor.inputSource else { return }
        
        router.goToDetailArticleModule(inputArticle: article, inputSource: source, animated: true)
    }
    
    func getArticlesFromSearchText(text: String) {
        interactor.getArticlesFromSearchText(text: text)
    }
    
}

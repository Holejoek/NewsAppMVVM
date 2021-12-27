//
//  Builder.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createNewsSourcesModule() -> UIViewController
    static func createSourceArticlesModule(inputSource: Source) -> ArticleRouterProtocol
    static func createDetailArticleModule(inputArticle: Article, inputSource: Source) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    static func createNewsSourcesModule() -> UIViewController {
        let view = SourcesViewController()
        let networkService = NetworkService()
        let viewModel = SourcesViewModel(view: view, networkService: networkService)
        view.viewModel = viewModel
        return view
    }
    
    static func createSourceArticlesModule(inputSource: Source) -> ArticleRouterProtocol {
        let router = ArticleRouter()
        let networkService = NetworkService()
        
        let view: ArticlesViewProtocol = ArticlesViewController()
        let presenter: ArticlePresenterProtocol = ArticlePresenter(view: view)
        let interactor: ArticleInteractorProtocol = ArticleInteractor(presenter: presenter, networkService: networkService, inputSource: inputSource)
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        return router
    }
    
    static func createDetailArticleModule(inputArticle: Article, inputSource: Source) -> UIViewController {
        let view = DetailViewController()
        let viewModel = DetailViewModel(view: view, inputArticle: inputArticle, inputSource: inputSource)
        view.viewModel = viewModel
        return view
    }
    
    
}

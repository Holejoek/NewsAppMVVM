//
//  ArticleRouter.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 27.12.2021.
//

import UIKit

class ArticleRouter: ArticleRouterProtocol {

    weak var navigationController: UINavigationController!
    
    required init(using navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToDetailArticleModule(inputArticle: Article, inputSource: Source, animated: Bool) {
        let nextScreen = ModuleBuilder.createDetailArticleModule(inputArticle: inputArticle, inputSource: inputSource)
        navigationController.pushViewController(nextScreen, animated: animated)
    }
}

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
    static func createSourceArticlesModule(inputId: String) -> UIViewController
    static func createDetailArticleModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    static func createNewsSourcesModule() -> UIViewController {
        let view = SourcesViewController()
        let networkService = NetworkService()
        let viewModel = SourcesViewModel(view: view, networkService: networkService)
        view.viewModel = viewModel
        return view
    }
    
    static func createSourceArticlesModule(inputId: String) -> UIViewController {
        let view = ArticlesViewController()
        let networkService = NetworkService()
        let viewModel = ArticlesViewModel(view: view, networkService: networkService)
        view.viewModel = viewModel
        return view
    }
    
    static func createDetailArticleModule() -> UIViewController {
        let view = DetailViewController()
        return view
    }
    
    
}

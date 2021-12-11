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
    static func createSourceArticlesModule() -> UIViewController
    static func createDetailArticleModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    static func createNewsSourcesModule() -> UIViewController {
        let view = SourcesViewController()
        let networkService = NetworkService()
        let viewModel = SourcesViewModel(networkService: networkService)
        view.viewModel = viewModel
        return view
    }
    
    static func createSourceArticlesModule() -> UIViewController {
        let view = ArticlesViewController()
        let networkService = NetworkService()
        return view
    }
    
    static func createDetailArticleModule() -> UIViewController {
        let view = DetailViewController()
        return view
    }
    
    
}

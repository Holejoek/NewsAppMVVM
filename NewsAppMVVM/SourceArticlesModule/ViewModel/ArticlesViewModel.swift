//
//  ArticlesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import CoreGraphics

//MARK: Input protocol
protocol ArticlesViewModelProtocol: AnyObject {
    init(view: ArticlesViewProtocol, networkService: NetworkServiceProtocol, inputSource: Source)
    //input tableView
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol
    func getNumberOfRows(inSection: Int) -> Int
    func getHeightOfRow(forIndexPath: IndexPath) -> CGFloat
    func getViewTitle() -> String
    //dataTransport
    func didSelect(indexPath: IndexPath) -> Article
    // networkService
    func getArticlesFromSourceId()
    func getArticlesFromSearchText(text: String)
    
}
//MARK: Output protocol
protocol ArticlesViewProtocol: AnyObject {
    func updateCells()
    func showError()
    func updating(_ flag: Bool)
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
    
    
    
    //MARK: - Input TableView
    func getArticleCellViewModel(indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        let article = loadedArticles[indexPath.row]
        getMoreData(indexPath: indexPath, searchFlag: searchFlag)
        return ArticleCellViewModel(title: article.title, author: article.author, publishedAt: article.convertedDate, imageURL: article.urlToImage)
    }

    func getNumberOfRows(inSection: Int) -> Int {
        return loadedArticles.count
    }
    
    func getHeightOfRow(forIndexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func getViewTitle() -> String {
        return inputSource.name
    }
    //MARK: - DataTransport
    
    func didSelect(indexPath: IndexPath) -> Article {
        let article = loadedArticles[indexPath.row]
        return article
    }
    
    //MARK: - NetworkService
    
    func getArticlesFromSourceId() {
        executeRequest(with: .load)
    }
    
    func getArticlesFromSearchText(text: String) {
        textForSearching = text.replacingOccurrences(of: " ", with: "_")
        executeRequest(with: .search)
    }
    
    private var loadedArticles = [Article]()
    private var totalResults: Int!
    private var currentPage: Int = 1
    private var textForSearching: String = ""
    private let maxNumberOfResults = 100
    private var searchFlag = false
    
    private enum TypeOfRequest {
        case load
        case loadMore
        case search
        case searchMore
    }
    
    private func executeRequest(with typeOfRequest: TypeOfRequest) {
        switch typeOfRequest {
        case .load:
            searchFlag = false
            currentPage = 1
            loadArticles()
        case .loadMore:
            currentPage += 1
            loadArticles()
        case .search:
            searchFlag = true
            currentPage = 1
            loadedArticles.removeAll()
            searchArticles()
        case .searchMore:
            currentPage += 1
            searchArticles()
        }
    }
    
    private func loadArticles() {
        self.view.updating(true)
        networkService.getSourceArticles(sourceId: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.loadedArticles += articles.articles
                    self?.totalResults = articles.totalResults
                case .failure(let error):
                    print(error)
                }
                self?.view.updateCells()
            }
        }
    }
    
    private func searchArticles() {
        self.view.updating(true)
        networkService.getArticlesFromSearch(searchText: textForSearching, ofSource: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.loadedArticles += articles.articles
                    self?.totalResults = articles.totalResults
                    print(articles.totalResults)
                case .failure(let error):
                    print(error)
                }
                self?.view.updateCells()
            }
        }
    }
    
    private func getMoreData(indexPath: IndexPath, searchFlag: Bool ) {
        guard loadedArticles.count < maxNumberOfResults else { return }
        guard loadedArticles.count < totalResults else { return }
        guard loadedArticles[indexPath.row].title == loadedArticles.last?.title  else { return }
        if searchFlag == false {
            executeRequest(with: .loadMore)
        } else {
            executeRequest(with: .searchMore)
        }
    }
}

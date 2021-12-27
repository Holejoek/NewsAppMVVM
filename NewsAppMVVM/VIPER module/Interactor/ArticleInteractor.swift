//
//  Interactor.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 27.12.2021.
//

import Foundation

protocol ArticleInteractorProtocol: AnyObject {
    
    var inputSource: Source! { get set }
    var outputArticles: [Article] { get set }
    
    var networkService: NetworkServiceProtocol! { get set }
    
    func getArticlesFromSourceId()
    func getArticleForRowAt(indexPath: IndexPath) -> Article
    func getArticlesFromSearchText(text: String)
}

class ArticleInteractor: ArticleInteractorProtocol {
    var networkService: NetworkServiceProtocol!
    
    weak var presenter: ArticlePresenterProtocol!
    var inputSource: Source!
    var outputArticles = [Article]()  // MARK: НУЖЕН DIDSET??
    
    required init(presenter: ArticlePresenterProtocol, networkService: NetworkServiceProtocol, inputSource: Source) {
        self.networkService = networkService
        self.presenter = presenter
        self.inputSource = inputSource
    }
    
    //MARK: - NetworkService
    
    func getArticlesFromSourceId() {
        executeRequest(with: .load)
    }
    
    func getArticleForRowAt(indexPath: IndexPath) -> Article {
        getMoreData(indexPath: indexPath, searchFlag: false)
        return outputArticles[indexPath.row]
    }
    
    func getArticlesFromSearchText(text: String) {
        textForSearching = text.replacingOccurrences(of: " ", with: "_")
        executeRequest(with: .search)
    }
    
    
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
            outputArticles.removeAll()
            searchArticles()
        case .searchMore:
            currentPage += 1
            searchArticles()
        }
    }
    
    private func loadArticles() {
//        self.view.updating(activityIndicator: true)
        networkService.getSourceArticles(sourceId: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.outputArticles += articles.articles
                    self?.totalResults = articles.totalResults
                    print( self?.outputArticles )
                case .failure(let error):
                    print(error)
                }
//                self?.view.updateCells()
            }
        }
    }
    
    private func searchArticles() {
//        self.view.updating(activityIndicator: true)
        networkService.getArticlesFromSearch(searchText: textForSearching, ofSource: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.outputArticles += articles.articles
                    self?.totalResults = articles.totalResults
                case .failure(let error):
                    print(error)
                }
//                self?.view.updateCells()
            }
        }
    }
    
    private func getMoreData(indexPath: IndexPath, searchFlag: Bool ) {
        guard outputArticles.count < maxNumberOfResults else { return }
        guard outputArticles.count < totalResults else { return }
        guard outputArticles[indexPath.row].title == outputArticles.last?.title  else { return }
        if searchFlag == false {
            executeRequest(with: .loadMore)
        } else {
            executeRequest(with: .searchMore)
        }
    }
}



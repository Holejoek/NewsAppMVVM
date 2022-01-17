//
//  Interactor.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 27.12.2021.
//

import Foundation

class ArticleInteractor: ArticleInteractorProtocol {
    var networkService: NetworkServiceProtocol!
    
    weak var presenter: ArticlePresenterProtocol!
    var inputSource: Source!
    var outputArticles = Box([Article]())
    
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
        return outputArticles.value[indexPath.row]
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
            outputArticles.value.removeAll()
            searchArticles()
        case .searchMore:
            currentPage += 1
            searchArticles()
        }
    }
    
    private func loadArticles() {
        networkService.getSourceArticles(sourceId: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.outputArticles.value += articles.articles
                    self?.totalResults = articles.totalResults
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func searchArticles() {
        networkService.getArticlesFromSearch(searchText: textForSearching, ofSource: inputSource.id, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    guard let articles = articles else {
                        return
                    }
                    self?.outputArticles.value += articles.articles
                    self?.totalResults = articles.totalResults
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getMoreData(indexPath: IndexPath, searchFlag: Bool ) {
        guard outputArticles.value.count < maxNumberOfResults else { return }
        guard outputArticles.value.count < totalResults else { return }
        guard outputArticles.value[indexPath.row].title == outputArticles.value.last?.title  else { return }
        if searchFlag == false {
            executeRequest(with: .loadMore)
        } else {
            executeRequest(with: .searchMore)
        }
    }
}



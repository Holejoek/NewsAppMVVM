//
//  NewsAppMVVMTests.swift
//  NewsAppMVVMTests
//
//  Created by Иван Тиминский on 11.12.2021.
//

import XCTest
@testable import NewsAppMVVM

class NewsAppMVVMTests: XCTestCase {
    
    var presenter: ArticlePresenterProtocol!
    var interactor: ArticleInteractorMock!
    var view: ArticlesViewControllerMock!
    var networkService: NetworkServiceMock!
    var router: ArticleRouterMock!
    
//    let expectation = XCTestExpectation!
    let inputSource = Source(id: "007", name: "Boston", description: "My name is Newspapaer", url: "//lol", category: "Category", language: "Russian", country: "Polska")
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = ArticlesViewControllerMock()
        presenter = ArticlePresenter(view: view)
        networkService = NetworkServiceMock()
        interactor = ArticleInteractorMock(inputSource: inputSource, networkService: networkService)
        router = ArticleRouterMock()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }

    func testNotifyThatViewDidLoad() {
        
        presenter.notifyThatViewDidLoad()
        
        XCTAssertTrue(view.isShowActivityIndicatorCalled)
        XCTAssertEqual(view.updateCellsIsCalledCount, 1)
    }

    func testUserPushedOnTheRow() {
        let index = IndexPath(row: 0, section: 0)
        presenter.notifyThatViewDidLoad()
        presenter.didSelectRowAt(indexPath: index)
       
        XCTAssertTrue(router.isGoToDetailArticleModuleCalled)
        
    }
    override func tearDownWithError() throws {
        presenter = nil
        interactor = nil
        view = nil
        networkService = nil
        try super.tearDownWithError()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class ArticleInteractorMock: ArticleInteractorProtocol {
    var inputSource: Source!
    var outputArticles = Box([Article]())
    var networkService: NetworkServiceProtocol!
    
    init(inputSource: Source, networkService: NetworkServiceProtocol) {
        self.inputSource = inputSource
        self.networkService = networkService
    }
    
    var getArticlesFromSourceIdIsCalledCount = 0
    func getArticlesFromSourceId() {
        let article = Article(source: inputSource, author: "", title: "Brew", description: "Bro", url: "Green", urlToImage: "", publishedAt: "", content: "")
        
        getArticlesFromSourceIdIsCalledCount += 1
        outputArticles = Box([article])
    }
    
    func getArticleForRowAt(indexPath: IndexPath) -> Article {
        let article = Article(source: inputSource, author: "", title: "Brew", description: "Bro", url: "Green", urlToImage: "", publishedAt: "", content: "")
        return article
    }
    
    func getArticlesFromSearchText(text: String) {
        return
    }
}


class ArticlesViewControllerMock: ArticlesViewProtocol {
    var presenter: ArticlePresenterProtocol!
    
    var updateCellsIsCalledCount = 0
    func updateCells() {
        updateCellsIsCalledCount += 1
    }
    
    func showError(with: Error) {
        return
    }
    
    var isShowActivityIndicatorCalled = false
    func showActivityIndicator(isActive: Bool) {
        isShowActivityIndicatorCalled = true
    }
    
    
}

class NetworkServiceMock: NetworkServiceProtocol {
    func getSources(completion: @escaping (Result<NewsSourcesData?, Error>) -> Void) {
        return
    }
    
    func getSourceArticles(sourceId: String, page: Int, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void) {
        return
    }
    
    func getArticlesFromSearch(searchText: String, ofSource: String, page: Int, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void) {
        return
    }
}

class ArticleRouterMock: ArticleRouterProtocol {
    
    var isGoToDetailArticleModuleCalled = false
    func goToDetailArticleModule(inputArticle: Article, inputSource: Source, animated: Bool) {
        isGoToDetailArticleModuleCalled = true
    }
}

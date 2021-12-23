//
//  DetailViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation

//MARK: Input
protocol DetailViewModelProtocol: AnyObject {
    init(view: DetailViewControllerProtocol, inputArticle: Article, inputSource: Source)
    
    func getAuthor() -> String
    func getTitle() -> String
    func getContent() -> String
    func getPublishedDate() -> String
    func getImageURL() -> String
    func getArticleURL() -> String
    
    func getControllerTitle() -> String
    
}

//MARK: Output
protocol DetailViewControllerProtocol: AnyObject {
    func updateView()
}

final class DetailViewModel: DetailViewModelProtocol {
    
    weak var view: DetailViewControllerProtocol!
    let inputArticle: Article!
    let inputSource: Source!
    
    init(view: DetailViewControllerProtocol, inputArticle: Article, inputSource: Source) {
        self.view = view
        self.inputArticle = inputArticle
        self.inputSource = inputSource
        updateView()
    }
    
    func getAuthor() -> String {
        guard let author = inputArticle.author else { return ""}
        return author
    }
    
    func getTitle() -> String {
        guard let title = inputArticle.title else { return ""}
        return title
    }
    
    func getContent() -> String {
        guard let content = inputArticle.content else { return ""}
        return content
    }
    
    func getPublishedDate() -> String {
        return inputArticle.convertedDate
    }
    
    func getImageURL() -> String {
        guard let url = inputArticle.urlToImage else { return ""}
        return url
    }
    
    func getArticleURL() -> String {
        guard let url = inputArticle.url else { return ""}
        return url
    }
    
    func getControllerTitle() -> String {
        return inputSource.name
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.view.updateView()
        }
    }
    
    
}

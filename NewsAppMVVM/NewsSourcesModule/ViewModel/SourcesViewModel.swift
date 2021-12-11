//
//  SourcesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation

//MARK: INPUT
protocol SourcesViewModelProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol)
    // INPUT for collectionView
    func someFunc() -> Int
    // NetworkService
    func getSources()
}

//MARK: OUTPUT
protocol SourcesViewProtocol: AnyObject {
    
}


final class SourcesViewModel: SourcesViewModelProtocol {
    
    let networkService: NetworkServiceProtocol!
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    var sourcesNames = Box([String]())
    var sourcesNameId: [String]!
    
    //MARK: INPUT for collectionView
    func someFunc() -> Int {
        return 1
    }
    
    //MARK: NetworkService
    func getSources() {
        networkService.getSources { [weak self] result in
            switch result {
            case .success(let sources):
                self?.sourcesNames.value = sources?.sources.map({ $0.name })
                self?.sourcesNameId = sources?.sources.map({ $0.id })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

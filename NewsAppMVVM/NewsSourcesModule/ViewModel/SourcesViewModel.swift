//
//  SourcesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import CoreGraphics


//MARK: INPUT
protocol SourcesViewModelProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol)
    // init collectionView
    func numberOfSection() -> Int
    func itemsInSection() -> Int
    
    var spaceBetweenItems: CGFloat { get }
    func itemInRow() -> CGFloat
    func sizeForItem(sizeOfView: CGSize) -> CGSize
    
    // NetworkService
    func getSources()
    var sourcesNameId: [String]! { get set}  // request
    // Data Binding
    var sourceNames: Box<[String]> { get set }
    var sourceCategories: Box<[String]> { get set }
}

//MARK: OUTPUT
protocol SourcesViewProtocol: AnyObject {
    
}


final class SourcesViewModel: SourcesViewModelProtocol {
    
    let networkService: NetworkServiceProtocol!
    
    var sourceNames = Box([String]())
    var sourceCategories = Box([String]())
    var sourcesNameId: [String]!
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    //MARK: init collectionView
    var spaceBetweenItems: CGFloat = 20
    
    func numberOfSection() -> Int {
        return 1
    }
    func itemsInSection() -> Int {
        return sourceNames.value.count
    }
    
    func itemInRow() -> CGFloat {
        return 2
    }
    func sizeForItem(sizeOfView: CGSize) -> CGSize {
        let itemWidth = (sizeOfView.width - spaceBetweenItems * itemInRow()) / itemInRow()
        let itemHeight = (sizeOfView.width - spaceBetweenItems * itemInRow()) / itemInRow()
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    //MARK: NetworkService
    func getSources() {
        networkService.getSources { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sources):
                    self?.sourceNames.value = sources?.sources.map({ $0.name })
                    self?.sourceCategories.value = sources?.sources.map({ $0.category ?? "Default"})
                    self?.sourcesNameId = sources?.sources.map({ $0.id })
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
}

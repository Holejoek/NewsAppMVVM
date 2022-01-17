//
//  SourcesViewModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import CoreGraphics
import UIKit


//MARK: INPUT
protocol SourcesViewModelProtocol: AnyObject {
    init(view: SourcesViewProtocol, networkService: NetworkServiceProtocol)
    // init collectionView
    func numberOfSection() -> Int
    func itemsInSection() -> Int
    var spaceBetweenItems: CGFloat { get }
    func itemInRow() -> CGFloat
    func sizeForItem(sizeOfView: CGSize) -> CGSize
    func minimumSpacingForItemsInSection() -> CGFloat
    func sectionInsets() -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    // NetworkService
    func getSources()
    var sources: [Source]! { get set}
    // Data Binding
    var sourceNames: Box<[String]> { get set }
    var sourceCategories: Box<[String]> { get set }
    // Data transporting
    func didSelect(indexPath: IndexPath) -> Source
}

//MARK: OUTPUT
protocol SourcesViewProtocol: AnyObject {
    func showError(error: Error?, orSomeErrorText: String?)
    func updateData()
}



final class SourcesViewModel: SourcesViewModelProtocol {

    let networkService: NetworkServiceProtocol!
    weak var view: SourcesViewProtocol!
    
    //MARK: - DataBinding
    var sourceNames = Box([String]())
    var sourceCategories = Box([String]())
    var sources: [Source]!
    
    init(view: SourcesViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    //MARK: - Init collectionView
    
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
        let itemWidth = (sizeOfView.width - spaceBetweenItems * (itemInRow() + 1)) / itemInRow()
        let itemHeight = (sizeOfView.width - spaceBetweenItems * (itemInRow() + 1)) / itemInRow()
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func minimumSpacingForItemsInSection() -> CGFloat {
        return spaceBetweenItems
    }
    
    func sectionInsets() -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        let top = spaceBetweenItems
        let left = spaceBetweenItems
        let bottom = spaceBetweenItems
        let right = spaceBetweenItems
        return (top: top, left: left, bottom: bottom, right: right)
    }
    
    //MARK: NetworkService
    func getSources() {
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(checkTimeNetConnection), userInfo: nil, repeats: false) // Если страница не загружается в течении некоторого времени, то выкидывается ошибка
        networkService.getSources { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sources):
                    self?.sourceNames.value = sources?.sources.map({ $0.name })
                    self?.sourceCategories.value = sources?.sources.map({ $0.category ?? "generic"})
                    self?.sources = sources?.sources
                    self?.view.updateData()
                case .failure(let error):
                    self?.view.showError(error: error, orSomeErrorText: nil)
                    print(error)
                }
            }
        }
    }
    
    @objc func checkTimeNetConnection() {
        if sources == nil {
            self.view.showError(error: nil,  orSomeErrorText: "Медленное интернет соединение")
            return
        }
    }
    
    //MARK: - Data transporting
    
    func didSelect(indexPath: IndexPath) -> Source {
        let selectedItem = indexPath.item
        let selectedSource = sources[selectedItem]
        return selectedSource
    }
}

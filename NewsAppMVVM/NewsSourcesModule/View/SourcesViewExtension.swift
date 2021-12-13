//
//  ViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 12.12.2021.
//

import Foundation
import UIKit


extension SourcesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SourcesCell.identifier, for: indexPath) as! SourcesCell
        let sourceName = sourceNames[indexPath.item]
        let sourceCategory = sourceCategories[indexPath.item]
        cell.updateCell(sourceName: sourceName, sourceCategory: sourceCategory)
        return cell 
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.viewModel.sizeForItem(sizeOfView: view.frame.size)
    }
    
    
}

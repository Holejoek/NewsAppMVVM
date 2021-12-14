//
//  ViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 12.12.2021.
//

import Foundation
import UIKit


extension SourcesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sourceArticlesScreen = ModuleBuilder.createSourceArticlesModule(inputId: self.viewModel.didSelect(indexPath: indexPath))
        self.navigationController?.pushViewController(sourceArticlesScreen, animated: true)
    }
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.viewModel.minimumSpacingForItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        self.viewModel.minimumSpacingForItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = self.viewModel.sectionInsets()
        return UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    }
    
}

//
//  ViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 12.12.2021.
//

import Foundation
import UIKit


extension SourcesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { // + Animations : UINavigationControllerDelegate
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        configureNavBackIten()
        // Animations
//        selectedIndexOfCell = indexPath
//        selectedCell = collectionView.cellForItem(at: selectedIndexOfCell!)
    
        let sourceArticlesScreen = ModuleBuilder.createSourceArticlesModule(using: navigationController ?? UINavigationController(), inputSource: self.viewModel.didSelect(indexPath: indexPath))
        navigationController?.pushViewController(sourceArticlesScreen, animated: true)
    }
    
   
    
    private func configureNavBackIten() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.style = .plain
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
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
         //Animation
//        if selectedIndexOfCell != nil  {
//            if selectedIndexOfCell!.row == indexPath.row {
//                cell.isHidden = true
//            }
//        }
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
    
    //MARK: - UINavigationControllerDelegate
    //Animation
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        guard let cell = selectedCell else { return nil }
//
//        if operation == .push {
//            print(cell.frame, cell)
//            return SourceCellTransitionAnimator(presentationStartCell: cell, isPresenting: true)
//
//        } else if operation == .pop {
//            return SourceCellTransitionAnimator(presentationStartCell: cell, isPresenting: false)
//        }
//        return nil
//    }
}


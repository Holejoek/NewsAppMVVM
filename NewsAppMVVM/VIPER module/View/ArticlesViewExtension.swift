//
//  ArticlesViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 14.12.2021.
//

import Foundation
import UIKit

extension ArticlesViewController: ArticlesViewProtocol {
    func showError(with: Error) {
        return
    }
    
    func updateCells() {
        showActivityIndicator(isActive: false)
        articlesTableView.reloadData()
    }
    
    func showActivityIndicator(isActive: Bool) {
        activityIndicator.isHidden = !isActive
        switch isActive {
        case true:
            activityIndicator.startAnimating()
        case false:
            activityIndicator.stopAnimating()
        }
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows(forSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(from: presenter.getArticleCellViewModel(indexPath: indexPath)) as! UITableViewCell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(presenter.getHeightOfRow(forIndexPath: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configureNavBackIten()
        presenter.didSelectRowAt(indexPath: indexPath)
    }
    
    private func configureNavBackIten() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.style = .plain
        backItem.tintColor = .black
        
        navigationItem.backBarButtonItem = backItem
    }
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.getArticlesFromSearchText(text: searchText)
    }
}

extension UITableView {
    func getCell(from vm: ArticleCellViewModelProtocol) -> ArticleCellProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: vm.associatedClass.identifier) as? ArticleCellProtocol else { fatalError() }
        cell.configure(with: vm)
        return cell
    }
}

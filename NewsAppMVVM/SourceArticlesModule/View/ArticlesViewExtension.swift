//
//  ArticlesViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 14.12.2021.
//

import Foundation
import UIKit

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(from: viewModel.getArticleCellViewModel(indexPath: indexPath)) as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightOfRow(forIndexPath: indexPath)
    }
    
}

extension UITableView {
    func getCell(from vm: ArticleCellViewModelProtocol) -> ArticleCellProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: vm.associatedClass.identifier) as? ArticleCellProtocol else { fatalError() }
        cell.configure(with: vm)
        return cell
    }
}

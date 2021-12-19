//
//  ArticlesViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import UIKit


class ArticlesViewController: UIViewController {
    
    var viewModel: ArticlesViewModel!
    lazy var articlesTableView: UITableView = makeTableView()
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticlesFromSourceId()
        configureViewController()
        
    }
    
    private func configureViewController() {
        title = viewModel.getVCTitile()
        view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
        
        configureSearchController()
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        return tableView
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchResultsUpdater = self
//        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
//        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.placeholder = "Only English please"
        searchController.searchBar.searchTextField.backgroundColor = .secondMainBack
        
    }
  
}

extension ArticlesViewController: ArticlesViewProtocol {
    func showError() {
        return
    }
    
    func updateCells() {
        articlesTableView.reloadData()
    }
}

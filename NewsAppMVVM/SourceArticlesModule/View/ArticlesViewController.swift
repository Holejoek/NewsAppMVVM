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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    let searchController = UISearchController()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticlesFromSourceId()
        configureViewController()
        
    }
    
    private func configureViewController() {
        title = viewModel.getViewTitle()
        view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
        
        //DismissKeyBoard
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeybord))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
        
        
        configureSearchController()
        articlesTableView.addSubview(activityIndicator)
        activityIndicator.center = articlesTableView.center
    }
    
    @objc func dismissKeybord(sender: UITapGestureRecognizer) {
        self.searchController.searchBar.endEditing(true)
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
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        
        
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
        updating(false)
    }
    
    func updating(_ flag: Bool) {
        activityIndicator.isHidden = flag
        switch flag {
        case true:
            activityIndicator.startAnimating()
        case false:
            activityIndicator.stopAnimating()
        }
    }
}

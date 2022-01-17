//
//  ArticlesViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import UIKit


class ArticlesViewController: UIViewController {
    
    var presenter: ArticlePresenterProtocol!
    
    lazy var articlesTableView: UITableView = makeTableView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        presenter.notifyThatViewDidLoad()
    }
    
    private func configureViewController() {
        title = presenter.getTitle()
        view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)

        configureSearchController()
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        tableView.addSubview(activityIndicator)
        activityIndicator.center = tableView.center
        
        return tableView
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.placeholder = "Only English please"
        searchController.searchBar.searchTextField.backgroundColor = .secondMainBack
        
        //DismissKeyBoard
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeybord))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc func dismissKeybord(sender: UITapGestureRecognizer) {
        searchController.searchBar.endEditing(true)
    }
    
}


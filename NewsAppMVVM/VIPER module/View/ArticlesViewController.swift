//
//  ArticlesViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import UIKit

protocol ArticlesViewProtocol: AnyObject {
    var presenter: ArticlePresenterProtocol! { get set }
    
    func updateCells()
    func showError()
    func updating(activityIndicator isActive: Bool)
}

class ArticlesViewController: UIViewController {
    
    var presenter: ArticlePresenterProtocol!
    
    lazy var articlesTableView: UITableView = makeTableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    let searchController = UISearchController()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureViewController()        
    }
    
    private func configureViewController() {
        title = presenter.getTitle()
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
        DispatchQueue.main.async {
            self.articlesTableView.reloadData()
            self.updating(activityIndicator: false)
        }
    }
    
    func updating(activityIndicator isActive: Bool) {
        activityIndicator.isHidden = isActive
        switch isActive {
        case true:
            activityIndicator.startAnimating()
        case false:
            activityIndicator.stopAnimating()
        }
    }
}

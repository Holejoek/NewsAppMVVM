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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticlesFromSourceId()
        configureViewController()
    }
    
    private func configureViewController() {
        self.navigationItem.title = "Список новостей"
        view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
//        tableView.separatorColor = .clear
        self.view.addSubview(tableView)
        return tableView
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

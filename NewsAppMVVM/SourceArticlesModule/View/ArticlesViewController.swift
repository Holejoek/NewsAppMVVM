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
        configureViewController()
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.topItem?.title = "Выберите источник новостей"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20) ?? UIFont.systemFont(ofSize: 14)]
        view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        return tableView
    }
}

extension ArticlesViewController: ArticlesViewProtocol {
    
}

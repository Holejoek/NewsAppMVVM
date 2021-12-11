//
//  SourcesViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//


import UIKit

class SourcesViewController: UIViewController {
    
    var viewModel: SourcesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    private func configureViewController() {
        title = "News Sources"
        view.
    }
    
}

extension SourcesViewController: SourcesViewProtocol {
    
}

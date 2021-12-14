//
//  SourcesViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//


import UIKit

class SourcesViewController: UIViewController {
    
    var viewModel: SourcesViewModelProtocol!
    lazy var collectionView: UICollectionView = makeCollectionView()
    var sourceNames = [String]() 
    var sourceCategories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        makeDataBinding()
        self.collectionView.reloadData()
        viewModel.getSources()
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.topItem?.title = "Выберите источник новостей"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20) ?? UIFont.systemFont(ofSize: 14)]
        view.createGradient(firstColor: .startFirstMainBack, secondColor: .startSecondMainBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: true, finalGradien: [.firstMainBack, .secondMainBack])
    }
    
    private func makeCollectionView() -> UICollectionView{
        let layer = UICollectionViewFlowLayout()
        layer.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "SourcesCell", bundle: nil), forCellWithReuseIdentifier: "SourceCell")
        // constaints
        let safeAreaInsets = UIApplication.shared.windows[0].safeAreaInsets.top + (self.navigationController?.navigationBar.frame.height ?? 0)  // Необходимо найти альтернативу
        collectionView.frame.origin.y = safeAreaInsets
        collectionView.frame.size.height -= safeAreaInsets
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        return collectionView
    }
    
    private func makeDataBinding() {
        self.viewModel.sourceNames.bind { [weak self] names in
            self?.sourceNames = names
        }
        self.viewModel.sourceCategories.bind { [weak self] categories in
            self?.sourceCategories = categories
        }
    }
    
}

//MARK: - Extension
extension SourcesViewController: SourcesViewProtocol {
    func showError(error: Error) {
        let errorNetAlert = UIAlertController(title: "Ошибка", message: "Нет доступа к интернету", preferredStyle: .alert)
        let errorNetAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        errorNetAlert.addAction(errorNetAction)
        self.present(errorNetAlert, animated: true, completion: nil)
    }
    func updateData() {
        self.collectionView.reloadData()
    }
}



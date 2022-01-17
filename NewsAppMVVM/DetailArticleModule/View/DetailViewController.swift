//
//  DetailViewController.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
     
    let scrollView = UIScrollView()
    let contentView = UIView()
    let author = UILabel(text: "", fontSize: 16, fontName: "Baskerville", textColor: .black, textAlignment: .right, shadowColor: .systemGray, numberOfLines: 0)
    let articleTitle = UILabel(text: "", fontSize: 20, fontName: "Baskerville", textColor: .black, textAlignment: .justified, shadowColor: .systemGray, numberOfLines: 0)
    let content = UILabel(text: "", fontSize: 18, fontName: "Baskerville", textColor: .black, textAlignment: .justified, shadowColor: nil, numberOfLines: 0)
    let publishedAt = UILabel(text: "", fontSize: 16, fontName: "Baskerville", textColor: .black, textAlignment: .right, shadowColor: nil, numberOfLines: 1)
    let articleImage = UIImageView(image: UIImage(), cornerRadius: 20, contentMode: .scaleAspectFill)
    let articleURL = UILabel(text: "", fontSize: 14, fontName: "Baskerville", textColor: .systemGray, textAlignment: .left, shadowColor: nil, numberOfLines: 0)
    
    
    func viewConfiguration() {
        self.view.createGradient(firstColor: .firstMainBack, secondColor: .secondMainBack, startPoint: CGPoint(x: 0,y: 0), endPoint: CGPoint(x: 0,y: 1), isAnimated: true, finalGradien: [.startSecondMainBack, .startFirstMainBack])
        title = viewModel.getControllerTitle()
        
        addElements()
    }
    
    private func addElements() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(author)
        self.contentView.addSubview(articleTitle)
        self.contentView.addSubview(content)
        self.contentView.addSubview(publishedAt)
        self.contentView.addSubview(articleImage)
        self.contentView.addSubview(articleURL)
        
    }
}

//MARK: View - ViewModel  (Output)
extension DetailViewController: DetailViewControllerProtocol {
    
    func updateView() {
        author.text = viewModel.getAuthor()
        articleTitle.text = viewModel.getTitle()
        content.text = viewModel.getContent()
        publishedAt.text = viewModel.getPublishedDate()
        articleURL.text = viewModel.getArticleURL()
        
        //MARK: SDWebImage
        
        guard let urlToImage = URL(string: viewModel.getImageURL()) else { return }
        
        articleImage.sd_setImage(with: urlToImage) { image, error, _, _ in
            if error != nil {
                self.articleImage.image = UIImage(named: "notFound") ?? UIImage()
            }
            if image == nil {
                self.articleImage.image = UIImage(named: "notFound") ?? UIImage()
            }
        }
    }
}

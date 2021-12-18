//
//  ArticleCell.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 14.12.2021.
//

import UIKit
import SDWebImage

protocol ArticleCellProtocol {
    static var identifier: String { get }
    
    func configure(with viewModel: ArticleCellViewModelProtocol)
}

class ArticleCell: UITableViewCell, ArticleCellProtocol {
    static var identifier = "ArticleCell"
    
    //MARK: Elements 
    var containerView = UIView()
    var title = UILabel(text: "", fontSize: 18, fontName: "Baskerville", textColor: .black, textAlignment: .left, shadowColor: nil, numberOfLines: 0)
    var author = UILabel(text: "", fontSize: 15, fontName: "Baskerville", textColor: .black, textAlignment: .center, shadowColor: nil, numberOfLines: 1)
    var publishedAt = UILabel(text: "", fontSize: 15, fontName: "Baskerville", textColor: .black, textAlignment: .right, shadowColor: nil, numberOfLines: 1)
    var articleImage = UIImageView(image: UIImage(), cornerRadius: 10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElementsOnCell()
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElementsOnCell(){
        self.backgroundColor = .clear
        self.addSubview(containerView)
        containerView.addSubview(title)
        containerView.addSubview(author)
        containerView.addSubview(publishedAt)
        containerView.addSubview(articleImage)
        containerView.backgroundColor = .clear
        makeConstraints()
    }

    func configure(with viewModel: ArticleCellViewModelProtocol) {
        guard let viewModel = viewModel as? ArticleCellViewModel else {
            self.title.text = "Error"
            self.author.text = ""
            self.publishedAt.text = ""
            self.articleImage.image = UIImage()
            return
        }
        self.title.text = viewModel.title
        self.author.text = viewModel.author
        self.publishedAt.text = viewModel.publishedAt
        guard let stringURL = viewModel.imageURL else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        
        self.articleImage.sd_setImage(with: imageURL, placeholderImage: UIImage())
    }

}


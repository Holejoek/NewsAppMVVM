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
    let containerView = UIView()
    let title = UILabel(text: "", fontSize: 15, fontName: "Baskerville", textColor: .black, textAlignment: .left, shadowColor: nil, numberOfLines: 4)
    let author = UILabel(text: "", fontSize: 18, fontName: "Baskerville", textColor: .black, textAlignment: .center, shadowColor: nil, numberOfLines: 2)
    let publishedAt = UILabel(text: "", fontSize: 15, fontName: "Baskerville", textColor: .black, textAlignment: .right, shadowColor: nil, numberOfLines: 1)
    let articleImage = UIImageView(image: UIImage(), cornerRadius: 10, contentMode: .scaleAspectFill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElementsOnCell()
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElementsOnCell(){
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(title)
        containerView.addSubview(author)
        containerView.addSubview(publishedAt)
        containerView.addSubview(articleImage)
        containerView.backgroundColor = .clear
        makeConstraints()
    }

    func configure(with viewModel: ArticleCellViewModelProtocol) {
        guard let viewModel = viewModel as? ArticleCellViewModel else {
            title.text = "Error"
            author.text = ""
            publishedAt.text = ""
            articleImage.image = UIImage()
            return
        }
        title.text = viewModel.title
        author.text = viewModel.author
        publishedAt.text = viewModel.publishedAt
        guard let stringURL = viewModel.imageURL else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        
        //MARK: - SDWebImage
        articleImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        articleImage.sd_setImage(with: imageURL) { [weak self] image, error, _, _ in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.articleImage.image = UIImage(named: "notFound") ?? UIImage()
            }
            if image == nil {
                strongSelf.articleImage.image = UIImage(named: "notFound") ?? UIImage()
            }
        }
    }

}


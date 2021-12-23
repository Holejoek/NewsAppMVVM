//
//  DetailViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 22.12.2021.
//

import Foundation
import SnapKit

extension DetailViewController {
    
    func makeConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.right.left.equalTo(view)
        }
        
        articleImage.snp.makeConstraints { make in
            make.topMargin.equalTo(contentView).offset(12)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(view).dividedBy(4)
        }
        
        articleTitle.adjustsFontForContentSizeCategory = true
        articleTitle.snp.makeConstraints { make in
            make.topMargin.equalTo(articleImage.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        author.snp.makeConstraints { make in
            make.topMargin.equalTo(articleTitle.snp.bottom).offset(15)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        publishedAt.snp.makeConstraints { make in
            make.topMargin.equalTo(content.snp.bottomMargin).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        content.snp.makeConstraints { make in
            make.topMargin.equalTo(author.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        articleURL.snp.makeConstraints { make in
            make.top.equalTo(publishedAt.snp.bottom).offset(20)
            make.leftMargin.rightMargin.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
}

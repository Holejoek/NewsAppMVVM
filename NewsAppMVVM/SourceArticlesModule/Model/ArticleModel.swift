//
//  ArticleModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation


// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    private static let dateFormatter: DateFormatter = {
      var formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
      return formatter
    }()

    var convertedDate: Date {
        return Self.dateFormatter.date(from: publishedAt) ?? Date()
        }

}

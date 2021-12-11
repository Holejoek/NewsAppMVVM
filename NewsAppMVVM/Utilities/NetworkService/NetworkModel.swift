//
//  NetworkModel.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation



// MARK: - Sources
struct NewsSourcesData: Codable {
    var status: String
    var sources: [Source]
}



// MARK: - Articles
struct NewsArticlesData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}







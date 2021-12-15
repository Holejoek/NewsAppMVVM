//
//  NetworkService.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation


protocol NetworkServiceProtocol {
    func getSources(completion: @escaping (Result<NewsSourcesData?, Error>) -> Void)
    func getSourceArticles(sourceId: String, completion:  @escaping (Result<NewsArticlesData?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
    
    enum NewsAPIPath: String {
        case api = "https://newsapi.org/v2/top-headlines"
        case sources = "/sources?"
        case sourcesSearching = "?sources="
        case apiKey = "apiKey=d4dd1ca711bc4c039500209abd9d8bed"
    }
    
    func getSources(completion: @escaping (Result<NewsSourcesData?, Error>) -> Void) {
        let urlString = NewsAPIPath.api.rawValue + NewsAPIPath.sources.rawValue + NewsAPIPath.apiKey.rawValue
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(NewsSourcesData.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
   
    func getSourceArticles(sourceId: String, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void) {
        let urlString = NewsAPIPath.api.rawValue + NewsAPIPath.sourcesSearching.rawValue + sourceId + "&" + NewsAPIPath.apiKey.rawValue
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                print(data!)
                let obj = try JSONDecoder().decode(NewsArticlesData.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}


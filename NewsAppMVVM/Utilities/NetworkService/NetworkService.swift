//
//  NetworkService.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 11.12.2021.
//

import Foundation


protocol NetworkServiceProtocol {
    func getSources(completion: @escaping (Result<NewsSourcesData?, Error>) -> Void)
    func getSourceArticles(sourceId: String, page: Int, completion:  @escaping (Result<NewsArticlesData?, Error>) -> Void)
    func getArticlesFromSearch(searchText: String, ofSource: String, page: Int, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    enum NewsAPIPath: String {
        case base = "https://newsapi.org/v2"
        case topHeadlines = "/top-headlines"
        case everything = "/everything"
        case sources = "/sources"
    }
    // FirstScreen viewDidLoad
    func getSources(completion: @escaping (Result<NewsSourcesData?, Error>) -> Void) {
        
        let requestParameters = makeSrtingRequestParameters(with: .loadSources, sourceId: nil, page: nil, searchText: nil)
        let urlString = NewsAPIPath.base.rawValue + NewsAPIPath.topHeadlines.rawValue + NewsAPIPath.sources.rawValue + requestParameters
        
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
    // FirstScreen -> SecondScreen (SecondScreen viewDidLoad)
    func getSourceArticles(sourceId: String, page: Int, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void) {
        let requestParameters = makeSrtingRequestParameters(with: .loadArticles, sourceId: sourceId, page:  page, searchText: nil)
        let urlString = NewsAPIPath.base.rawValue + NewsAPIPath.everything.rawValue + requestParameters
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(NewsArticlesData.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // SearchBar SecondScreen
    func getArticlesFromSearch(searchText: String, ofSource: String, page: Int, completion: @escaping (Result<NewsArticlesData?, Error>) -> Void) {
        let requestParameters = makeSrtingRequestParameters(with: .searchArticles, sourceId: ofSource, page:  page, searchText: searchText)
        let urlString = NewsAPIPath.base.rawValue + NewsAPIPath.everything.rawValue + requestParameters
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(NewsArticlesData.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    //MARK: - Request Options
    
    enum RequestOptionsEnum {
        case loadSources
        case loadArticles
        case searchArticles
    }
    
    private func makeSrtingRequestParameters(with option: RequestOptionsEnum,
                                             sourceId: String?,
                                             page: Int?,
                                             searchText: String?) -> String {
        var requestParameters: [String: String] = [:]
        let apiKeyParameter = ["apiKey":"9470efed1eef49449c2097c448d9907b"]
        // 5c39d7658a104dcc949e70ae70e4d811 - Ya
        // bd361c9c77da4853a0d41fc628c91cf0 - Alena
        // d4dd1ca711bc4c039500209abd9d8bed - Ya2
        // 66058fed792b455384ed16b02f7c9a46 - Valera
        // 9470efed1eef49449c2097c448d9907b - ya3
        requestParameters.merge(with: apiKeyParameter)
        
        //GenericParameters
        let sortByParameter = ["sortBy": "publishedAt"]
        let pageSizeParameter = ["pageSize":"10"]
        //        let parameterDate = ["from":"2021-12-01"]
        
        // SourceParameters
        let languageParameter = ["language":"en"]
        //        let countryParameter = ["country":"us"]
        //        let categoryParameter = ["category":"business"]
        
        switch option {
        case .loadSources:
            requestParameters.merge(with: languageParameter)
            return requestParameters.createURLPath(keyOfLastParameter: "apiKey")
        case .loadArticles:
            guard let sourceId = sourceId else { fatalError() }
            let sourceIdParameter = ["sources":sourceId]
            
            guard let page = page else { fatalError() }
            let currentPageParameter = ["page":"\(page)"]
            
            requestParameters.merge(with: sourceIdParameter)
            requestParameters.merge(with: currentPageParameter)
            requestParameters.merge(with: pageSizeParameter)
            requestParameters.merge(with: sortByParameter)
            return requestParameters.createURLPath(keyOfLastParameter: "apiKey")
        case .searchArticles:
            guard let sourceId = sourceId else { fatalError() }
            let sourceIdParameter = ["sources":sourceId]
            
            guard let searchText = searchText else { fatalError() }
            let queryParameter = ["q": searchText]
            
            guard let page = page else { fatalError() }
            let currentPageParameter = ["page":"\(page)"]
            
            requestParameters.merge(with: currentPageParameter)
            requestParameters.merge(with: sourceIdParameter)
            requestParameters.merge(with: queryParameter)
            requestParameters.merge(with: pageSizeParameter)
            requestParameters.merge(with: sortByParameter)
            return requestParameters.createURLPath(keyOfLastParameter: "apiKey")
        }
    }
    
    
}


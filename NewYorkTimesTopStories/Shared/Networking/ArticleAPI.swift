//
//  ArticleAPI.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import Foundation

struct GetArticleParam {
    public let webURL: String
    public let fl: String = "lead_paragraph"
    
    var encodedWebURLParam: String {
        return "web_url" + ":" + "\"\(webURL)\""
    }
}

protocol ArticleLoader {
    typealias Result = Swift.Result<ArticleResult, Error>
    func getArticle(with url: String, completion: @escaping (Result) -> Void)
}

struct RemoteArticleLoader: ArticleLoader {
    func getArticle(with url: String, completion: @escaping (ArticleLoader.Result) -> Void) {
        let endpoint = NYTEndpoint.getArticle(GetArticleParam(webURL: url))
        URLSession.shared.dataTask(with: endpoint.httpRequest, completionHandler: { data, response, error in
            if error != nil {
                completion(.failure(RemoteTopStoriesLoader.Error.connectivity))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(RemoteTopStoriesLoader.Error.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(RemoteTopStoriesLoader.Error.invalidData))
                return
            }
            
            guard let topStoriesResponse = try? JSONDecoder().decode(ArticleResult.self, from: data) else {
                completion(.failure(RemoteTopStoriesLoader.Error.invalidData))
                return
            }
            completion(.success(topStoriesResponse))
        }).resume()
    }
}

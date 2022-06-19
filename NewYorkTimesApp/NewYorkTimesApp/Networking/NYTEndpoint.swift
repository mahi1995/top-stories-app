//
//  NYTEndpoint.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 15/06/2022.
//

import Foundation

enum NYTEndpoint {
    case getTopStories(GetTopStories)
    case getArticle(GetArticleParam)
}

extension NYTEndpoint {
    private var baseURL: String { "https://api.nytimes.com" }
    private var apiKey: String { "0La0hbqYYk03yAjIRMzjDkyvkDUOMp20" }
    private var path: String {
        switch self {
        case .getTopStories(let getTopStories):
            return "/svc/topstories/v2/\(getTopStories.section).json"
        case .getArticle(_):
            return "/svc/search/v2/articlesearch.json"
        }
    }
    
    private var parameters: [String: String] {
        switch self {
        case .getTopStories(_):
            return ["api-key": apiKey]
        case .getArticle(let param):
            return ["fl": param.fl,
                    "fq": param.webURLParam,
                    "api-key": apiKey]
        }
    }
    
    private var requestURL: URL {
        var components = URLComponents(string: baseURL + path)
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove(":")
        components?.percentEncodedQuery = parameters.map {
            $0.addingPercentEncoding(withAllowedCharacters: characterSet)!
            + "=" + $1.addingPercentEncoding(withAllowedCharacters: characterSet)!
        }.joined(separator: "&")
        
        return components?.url ?? URL(string: baseURL + path)!
    }
    
    var httpRequest: URLRequest {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}

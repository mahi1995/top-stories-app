//
//  TopStoriesAPI.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 10/06/2022.
//

import Foundation

struct GetTopStories {
    public let section: String
}

protocol TopStoriesLoader {
    typealias Result = Swift.Result<TopStoriesResponse, Error>
    func getTopStories(completion: @escaping (Result) -> Void)
}

struct RemoteTopStoriesLoader: TopStoriesLoader {
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    func getTopStories(completion: @escaping (TopStoriesLoader.Result) -> Void) {
        let endpoint = NYTEndpoint.getTopStories(GetTopStories(section: "home"))
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
            
            guard let topStoriesResponse = try? JSONDecoder().decode(TopStoriesResponse.self, from: data) else {
                completion(.failure(RemoteTopStoriesLoader.Error.invalidData))
                return
            }
            completion(.success(topStoriesResponse))
        }).resume()
    }
}

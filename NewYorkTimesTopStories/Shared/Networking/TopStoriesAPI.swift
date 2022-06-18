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

public enum Error: Swift.Error {
    case connectivity
    case invalidData
}

extension Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectivity:
            return NSLocalizedString("Please check your network connection and try again.", comment: "Connectivity Error")
        case .invalidData:
            return NSLocalizedString("Oops, we have encountered an error. Please try again.", comment: "Invalid data returned")
        }
    }
    
    static var genericErrorDescription: String {
        return "An error has been encountered. Please try again later."
    }
}

struct RemoteTopStoriesLoader: TopStoriesLoader {
    func getTopStories(completion: @escaping (TopStoriesLoader.Result) -> Void) {
        let endpoint = NYTEndpoint.getTopStories(GetTopStories(section: "home"))
        URLSession.shared.dataTask(with: endpoint.httpRequest, completionHandler: { data, response, error in
            if error != nil {
                completion(.failure(Error.connectivity))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(Error.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(Error.invalidData))
                return
            }
            
            guard let topStoriesResponse = try? JSONDecoder().decode(TopStoriesResponse.self, from: data) else {
                completion(.failure(Error.invalidData))
                return
            }
            completion(.success(topStoriesResponse))
        }).resume()
    }
}

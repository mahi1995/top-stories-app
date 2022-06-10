//
//  TopStoriesAPI.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 10/06/2022.
//

import Foundation

struct Response: Codable {
    var status: String
    var lastUpdated: String
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case articles = "results"
        case lastUpdated = "last_updated"
    }
}

struct Article: Codable {
    var url: String
    var title: String
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case author = "byline"
    }
}

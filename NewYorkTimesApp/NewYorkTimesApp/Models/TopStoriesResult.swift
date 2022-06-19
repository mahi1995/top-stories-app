//
//  TopStoriesResult.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 10/06/2022.
//

struct TopStoriesResponse: Codable {
    var status: String
    var lastUpdated: String
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case articles = "results"
        case lastUpdated = "last_updated"
    }
}

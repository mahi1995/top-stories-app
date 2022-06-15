//
//  Article.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 10/06/2022.
//

struct Article: Codable {
    var url: String
    var title: String
    var author: String
    var multimedia: [Multimedia]
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case author = "byline"
        case multimedia
    }
}

struct Multimedia: Codable {
    var url: String
    var width: Float
    var height: Float
}

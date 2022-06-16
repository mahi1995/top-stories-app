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
    var multimedia: [Multimedia]?
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case author = "byline"
        case multimedia
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        multimedia = try container.decode([Multimedia]?.self, forKey: .multimedia)
    }
}

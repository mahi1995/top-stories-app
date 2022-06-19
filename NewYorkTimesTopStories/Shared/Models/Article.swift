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
    var description: String
    var publishingDate: String
    var multimedia: [Multimedia]?
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case author = "byline"
        case multimedia
        case description = "abstract"
        case publishingDate = "published_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        description = try container.decode(String.self, forKey: .description)
        multimedia = try container.decode([Multimedia]?.self, forKey: .multimedia)
        publishingDate = try container.decode(String.self, forKey: .publishingDate)
    }
    
    init(url: String,
         title: String,
         author: String,
         description: String,
         publishingDate: String,
         multimedia: [Multimedia]) {
        self.url = url
        self.title = title
        self.author = author
        self.description = description
        self.publishingDate = publishingDate
        self.multimedia = multimedia
    }
}

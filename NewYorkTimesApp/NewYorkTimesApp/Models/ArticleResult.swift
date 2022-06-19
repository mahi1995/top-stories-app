//
//  ArticleResult.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 16/06/2022.
//

import Foundation

struct ArticleResult: Codable {
    var documents: [Document]
    
    enum CodingKeys: String, CodingKey {
        case response
        case documents = "docs"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        documents = try response.decode([Document].self, forKey: .documents)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        try response.encode(self.documents, forKey: .documents)
    }
    
}

struct Document: Codable {
    var leadParagraph: String
    
    enum CodingKeys: String, CodingKey {
        case leadParagraph = "lead_paragraph"
    }
}

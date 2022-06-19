//
//  MockTopStoriesLoader.swift
//  NewYorkTimesAppTests
//
//  Created by Mahika on 19/06/2022.
//

import Foundation
@testable import NewYorkTimesApp

class MockTopStoriesLoader: TopStoriesLoader {
    var shouldReturnError: Bool = false
    var requestTopStories: Bool = false
    
    func reset() {
        shouldReturnError = false
        requestTopStories = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    var mockTopStoriesResponse: [String: Any] = [
        "status": "OK",
        "copyright": "some copyright",
        "section": "home",
        "last_updated": "2022-06-19T01:30:35-04:00",
        "num_results": 40,
        "results": [
            ["section": "health",
              "subsection": "",
              "title": "some title",
              "abstract": "some abstract",
              "url": "https://www.someURL.com/someArticle.html",
              "uri": "nyt://article/1234",
              "byline": "By some author",
              "item_type": "Article",
              "updated_date": "2022-06-18T23:08:55-04:00",
              "created_date": "2022-06-18T17:00:16-04:00",
              "published_date": "2022-06-18T17:00:16-04:00",
              "material_type_facet": "",
              "kicker": "",
              "multimedia": [
                [
                  "url": "https://static.url.com/firstImage.jpg",
                  "format": "Super Jumbo",
                  "height": 1364,
                  "width": 2048,
                  "type": "image",
                  "subtype": "photo",
                  "caption": "some caption.",
                  "copyright": "some copyright"
                ],
                [
                  "url": "https://static.url.com/secondImage.jpg",
                  "format": "threeByTwoSmallAt2X",
                  "height": 399,
                  "width": 600,
                  "type": "image",
                  "subtype": "photo",
                  "caption": "some caption",
                  "copyright": "some copyright"
                ],
                [
                  "url": "https://static.url.com/thirdImage.jpg",
                  "format": "Large Thumbnail",
                  "height": 150,
                  "width": 150,
                  "type": "image",
                  "subtype": "photo",
                  "caption": "some caption.",
                  "copyright": "some copyright"
                ]
              ],
              "short_url": "https://shorturl.com"
            ]]
    ]
    
    func getTopStories(completion: @escaping (TopStoriesLoader.Result) -> Void) {
        requestTopStories = true
        if shouldReturnError {
            completion(.failure(Error.invalidData))
        } else {
            guard let data = try? JSONSerialization.data(withJSONObject: mockTopStoriesResponse) else { return }
            guard let topStoriesResponse = try? JSONDecoder().decode(TopStoriesResponse.self, from: data) else {
                completion(.failure(Error.invalidData))
                return
            }
            completion(.success(topStoriesResponse))
        }
    }
}

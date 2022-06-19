//
//  MockArticleLoader.swift
//  NewYorkTimesAppTests
//
//  Created by Mahika on 19/06/2022.
//

import Foundation
@testable import NewYorkTimesApp

class MockArticleLoader: ArticleLoader {
    var shouldReturnError: Bool = false
    var isRequestExecuted: Bool = false
    
    func reset() {
        shouldReturnError = false
        isRequestExecuted = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    var mockResponse: [String: Any] = [
        "status": "OK",
        "copyright": "some copyright",
        "response": [
            "docs": [
                [
                    "lead_paragraph": "some lead paragraph"
                ]
            ],
            "meta": [
                "hits": 1,
                "offset": 0,
                "time": 6
            ]
        ]
    ]
    
    func getArticle(with url: String, completion: @escaping (ArticleLoader.Result) -> Void) {
        isRequestExecuted = true
        if shouldReturnError {
            completion(.failure(Error.invalidData))
        } else {
            guard let data = try? JSONSerialization.data(withJSONObject: mockResponse) else { return }
            guard let result = try? JSONDecoder().decode(ArticleResult.self, from: data) else {
                completion(.failure(Error.invalidData))
                return
            }
            completion(.success(result))
        }
    }
}

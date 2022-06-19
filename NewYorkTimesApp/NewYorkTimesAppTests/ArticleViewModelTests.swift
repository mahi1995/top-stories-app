//
//  ArticleViewModelTests.swift
//  NewYorkTimesAppTests
//
//  Created by Mahika on 19/06/2022.
//

import XCTest
@testable import NewYorkTimesApp

class ArticleViewModelTests: XCTestCase {
    var viewModel: ArticleViewModel!
    var loader: MockArticleLoader!
    
    override func setUp() {
        loader = MockArticleLoader()
        let articleDetail = ArticleDetail(title: "article title",
                                          description: "description of article",
                                          imageUrl: "some url",
                                          image: nil,
                                          author: "by author",
                                          publishDate: "2022-06-18T17:00:16-04:00",
                                          url: "https://www.someURL.com/someArticle.html")
        viewModel = ArticleViewModel(article: articleDetail, loader: loader)
    }
    
    override func tearDown() {
        loader.reset()
    }
    
    func testSuccessfulArticleSearchResponse() {
        let exp = expectation(description: "Wait for load completion")
        viewModel.fetchPreview { content in
            XCTAssertEqual(content, "some lead paragraph")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testErrorHandlingInCaseInvalidData() {
        loader.mockResponse = [
            "status": "OK",
            "copyright": "some copyright",
            "response": [
                "docs": [
                    [
                        "lead_paragraph": nil
                    ]
                ],
                "meta": [
                    "hits": 1,
                    "offset": 0,
                    "time": 6
                ]
            ]
        ]
        
        let exp = expectation(description: "Wait for load completion")
        viewModel.fetchPreview { errorMessage in
            XCTAssertEqual(errorMessage, "Oops, we have encountered an error. Please try again.")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testErrorHandlingForEmptyResponse() {
        loader.mockResponse = [
            "status": "OK",
            "copyright": "some copyright",
            "response": [
                "docs": [],
                "meta": [
                    "hits": 1,
                    "offset": 0,
                    "time": 6
                ]
            ]
        ]
        
        let exp = expectation(description: "Wait for load completion")
        viewModel.fetchPreview { errorMessage in
            XCTAssertEqual(errorMessage, "Oops! There is no preview for this article.")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testErrorHandlingInCaseErrorReturnedAsResponse() {
        loader.shouldReturnError = true
        
        let exp = expectation(description: "Wait for load completion")
        viewModel.fetchPreview { errorMessage in
            XCTAssertEqual(errorMessage, "Oops, we have encountered an error. Please try again.")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testDateFormat() {
        XCTAssertEqual(viewModel.date, "Published on June 19, 2022")
    }
}

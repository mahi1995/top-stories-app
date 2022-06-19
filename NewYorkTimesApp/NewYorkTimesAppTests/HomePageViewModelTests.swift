//
//  HomePageViewModelTests.swift
//  NewYorkTimesAppTests
//
//  Created by Mahika on 19/06/2022.
//

import XCTest
@testable import NewYorkTimesApp

class HomePageViewModelTests: XCTestCase {
    var loader: MockTopStoriesLoader!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        loader = MockTopStoriesLoader()
        viewModel = HomeViewModel(loader: loader)
    }
    
    func testCellViewModelsForSuccessfulAPIResponse() {
        let exp = expectation(description: "Wait for load completion")
        let expectedResponse = TopStoriesResponse(status: "OK",
                                                  lastUpdated: "2022-06-19T01:30:35-04:00",
                                                  articles: [Article(url: "https://www.someURL.com/someArticle.html",
                                                                     title: "some title",
                                                                     author: "By some author",
                                                                     description: "some abstract",
                                                                     publishingDate: "2022-06-18T17:00:16-04:00",
                                                                     multimedia: [Multimedia(url: "https://static.url.com/firstImage.jpg",
                                                                                             height: 1364,
                                                                                             width: 2048)])])
        viewModel.loadStories() { result in
            let cellViewModel = result as! [TopStoryCellViewModel]
            XCTAssertEqual(cellViewModel[0].imageURL, expectedResponse.articles[0].multimedia![0].url)
            XCTAssertEqual(cellViewModel[0].author, expectedResponse.articles[0].author)
            XCTAssertEqual(cellViewModel[0].title, expectedResponse.articles[0].title)
            XCTAssertEqual(cellViewModel[0].image, nil)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func testCellViewModelsOnEmptyJSONResponse() {
        loader.mockTopStoriesResponse = [:]
        let exp = expectation(description: "Wait for load completion")
        viewModel.loadStories() { result in
            let cellViewModel = result as! [EmptyCellViewModel]
            XCTAssertEqual(cellViewModel[0].informationMessage, "Oops, we have encountered an error. Please try again.")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func testCellViewModelsOnErrorResponse() {
        loader.shouldReturnError = true
        let exp = expectation(description: "Wait for load completion")
        viewModel.loadStories() { result in
            let cellViewModel = result as! [EmptyCellViewModel]
            XCTAssertEqual(cellViewModel[0].informationMessage, "Oops, we have encountered an error. Please try again.")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

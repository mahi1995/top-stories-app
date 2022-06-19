//
//  NYTEndpointTests.swift
//  NewYorkTimesAppTests
//
//  Created by Mahika on 19/06/2022.
//

import XCTest
@testable import NewYorkTimesApp

class NYTEndpointTests: XCTestCase {

    func testGetTopStoriesAPIIsValidURL() {
        let param = GetTopStories(section: "someSection")
        let endpoint = NYTEndpoint.getTopStories(param)
        
        XCTAssertEqual(endpoint.httpRequest.allHTTPHeaderFields, ["Accept": "application/json"])
        XCTAssertEqual(endpoint.httpRequest.httpMethod, "GET")
        XCTAssertTrue(endpoint.httpRequest.url!.query!.contains("api-key="))
        XCTAssertEqual(endpoint.httpRequest.url!.path, "/svc/topstories/v2/someSection.json")
    }
    
    func testGetArticleAPIIsValidURL() {
        let param = GetArticleParam(webURL: "https://www.someURL.com")
        let endpoint = NYTEndpoint.getArticle(param)
        let queries = endpoint.httpRequest.url!.query!.split(separator: "&")
        
        XCTAssertEqual(endpoint.httpRequest.allHTTPHeaderFields, ["Accept": "application/json"])
        XCTAssertEqual(endpoint.httpRequest.url!.path, "/svc/search/v2/articlesearch.json")
        XCTAssertEqual(endpoint.httpRequest.httpMethod, "GET")
        XCTAssertEqual(queries.first(where: { $0.contains("fl")}), "fl=lead_paragraph")
        
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove(":")
        let encodedArticleURL = param.webURLParam.addingPercentEncoding(withAllowedCharacters: characterSet)!
        XCTAssertEqual(queries.first(where: { $0.contains("fq")}), "fq=\(encodedArticleURL)")
        XCTAssertTrue(endpoint.httpRequest.url!.query!.contains("api-key="))
    }
}

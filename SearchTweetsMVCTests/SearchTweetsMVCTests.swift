//
//  SearchTweetsMVCTests.swift
//  SearchTweetsMVCTests
//
//  Created by Shibili Areekara on 02/03/19.
//  Copyright © 2019 Shibili Areekara. All rights reserved.
//

import XCTest
@testable import SearchTweetsMVC

class SearchTweetsMVCTests: XCTestCase {
    
    
    func testNilCaseFormattedString() {
        let date = Date().getFormattedDateString()
        XCTAssertNotNil(date)
    }
    
    func checkRequestInitialisation() {
        let sampleRequest = Request(search: "Shibili Areekara", count: 10)
        
        XCTAssertEqual(sampleRequest.parameters["q"], "Shibili Areekara")
        XCTAssertEqual(sampleRequest.parameters["count"], "10")
    }
    
    func checkImageLoadingFromUrl() {
        let imageUrlString = "this is not a url"
        
        let imageView = UIImageView()
        
        XCTAssertNil(imageView.loadImageFromUrl(urlString: imageUrlString))
    }
}

//
//  ApiMamnagerTestCase.swift
//  HNDemoTests
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 HNDemo. All rights reserved.
//

import XCTest
@testable import HNDemo

class ApiMamnagerTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // checking the top stories api
        HNApiManager.topStories { (result) in
            switch result {
            case .success(let result):
                XCTAssertTrue(result.count > 0, "got the data")
                break
            case .failure(_):
                break
            }
        }
        
        // checking the detailed api
        HNApiManager.storyDetails(storyID: "1") { (result) in
            switch result {
            case .success(let result):
                XCTAssertTrue(result.id ?? 0 > 0, "got the data")
                break
            case .failure(_):
                break
            }
        }
    
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  HNStoryViewModeTestCases.swift
//  HNDemoTests
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 HNDemo. All rights reserved.
//

import XCTest
@testable import HNDemo


class HNStoryViewModeTestCases: XCTestCase, HNDelegate {

    var viewModel : HNStoryViewModel?
    
    func testGettingData() {
        self.viewModel = HNStoryViewModel(self)
        self.viewModel?.fetchStories()
    }
    
    
    
    // check whether the delegation is working properly or not
    func refreshScreenData() {
//        check api result of story details
        print("called")
        XCTAssertEqual(self.viewModel?.numberOfRows(), self.viewModel?.storyDetails.count ?? 0)
        //hcekc api data is populated or not
        XCTAssertTrue(self.viewModel?.storyDetails.count ?? 0 > 0)
    }
}

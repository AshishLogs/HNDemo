//
//  HNStoryViewModel.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import Foundation

protocol HNDelegate: class {
    func refreshScreenData()
}

class HNStoryViewModel {
    
    weak var delegate : HNDelegate?
    
    init(_ delegate: HNDelegate?) {
        self.delegate = delegate
    }
    
    private var buffer : (start: Int, end: Int) = (0, 25)
    
   private var stories : HNStories? = [] {
        didSet {
            if let story = stories, story.count > 0 {
                for (index,element) in story.enumerated() {
                    if buffer.start <= index, buffer.end > index {
                        fetchDetails(id: String(element))
                        if index == buffer.end - 1 {
                            buffer.start = buffer.end
                            buffer.end   = buffer.end + 25
                            break
                        }
                    }
                }
            }
        }
    }
    
    var storyDetails : [HNStoryDetail] = [] {
        didSet {
            self.delegate?.refreshScreenData()
        }
    }
    
    func fetchStories() {
        HNApiManager.topStories { [weak self](response) in
            switch response {
            case .success(let result):
                self?.stories = result
            case .failure(let error):
                print(error)
                self?.stories = []
            }
        }
    }
    
    private func fetchDetails(id: String) {
        HNApiManager.storyDetails(storyID: id) { [weak self](response) in
            switch response {
            case .success(let result):
                self?.storyDetails.append(result)
            case .failure(_):
                break
            }
        }
    }
    
    func numberOfRows() -> Int {
        return self.storyDetails.count
    }
    
    func getStoryDetails(index: Int) -> HNStoryDetail? {
        if index < self.storyDetails.count {
            return self.storyDetails[index]
        }
        return nil
    }
    
    func fetchMore() {
        let details = self.stories
        self.stories = details
    }
    
}

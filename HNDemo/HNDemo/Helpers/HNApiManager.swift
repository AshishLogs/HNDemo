//
//  HNApiManager.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import Foundation

enum HNRouter {
    case topStories, storyDetail(id: String)
    var route : String {
        switch self {
        case .topStories:
            return HNConstants.ProductionServer.topStories
        case .storyDetail(let id):
            return String.init(format: "%@%@", HNConstants.ProductionServer.storiesDetailBase, id)
        }
    }
}

class HNApiManager {
    
    class func topStories(completion:@escaping (Result<HNStories, HNError>) -> Void) {
        perform(urlString: HNRouter.topStories.route, completion: completion)
    }
    
    class func storyDetails(storyID: String,  completion:@escaping (Result<HNStoryDetail, HNError>) -> Void) {
        perform(urlString: HNRouter.storyDetail(id: storyID).route, completion: completion)
    }
    
    private class func perform<T: Codable>(urlString: String, completion:@escaping (Result<T, HNError>) -> Void) {
        guard let safeURL = URL(string: urlString) else { return }
        var request = URLRequest(url: safeURL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(HNError.init(error: error)))
                }
            } else {
                completion(.failure(HNError.init(error: error)))
            }
        }.resume()
    }
    
}


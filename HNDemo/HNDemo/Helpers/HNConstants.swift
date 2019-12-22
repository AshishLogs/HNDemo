//
//  HNConstants.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import Foundation

struct HNConstants {
    struct ProductionServer {
        static let topStories = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
        static let storiesDetailBase = "http://hn.algolia.com/api/v1/items/"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}



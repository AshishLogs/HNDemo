//
//  BaseModel.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import Foundation
import UIKit

typealias HNStories = [Int]

struct HNError: Error {
    var error : Error?
    init(error: Error?) {
        self.error = error
    }
}

struct HNStoryDetail: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author, title: String?
    var url: String?
    var text: JSONNull?
    var points: Int?
    var parentID, storyID: JSONNull?
    var children: [HNStoryDetailChild]?
    var options: [JSONAny]?
    
    var formattedTime : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if let date = dateFormatter.date(from:self.createdAt ?? "") {
            return Date().offsetFrom(date: date)
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case createdAtI = "created_at_i"
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNStoryDetailChild
struct HNStoryDetailChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children: [HNStoryDetailChild]?
    var options: [JSONAny]?
    
    var attributedText : NSAttributedString? {
        guard let encodedData = self.text?.data(using: String.Encoding.utf8) else { return nil }
        do {
            return try? NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
        }
    }
    
    var formattedTime : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if let date = dateFormatter.date(from:self.createdAt ?? "") {
            return Date().offsetFrom(date: date)
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case createdAtI = "created_at_i"
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNPurpleChild
struct HNPurpleChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children: [HNFluffyChild]?
    var options: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case createdAtI
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNFluffyChild
struct HNFluffyChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type: String?
    var author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children: [HNTentacledChild]?
    var options: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case createdAtI
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNTentacledChild
struct HNTentacledChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children: [HNStickyChild]?
    var options: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case createdAtI
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNStickyChild
struct HNStickyChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children: [HNIndigoChild]?
    var options: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case createdAtI
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - HNIndigoChild
struct HNIndigoChild: Codable {
    var id: Int?
    var createdAt: String?
    var createdAtI: Int?
    var type, author: String?
    var title, url: JSONNull?
    var text: String?
    var points: JSONNull?
    var parentID, storyID: Int?
    var children, options: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case createdAtI
        case type, author, title, url, text, points
        case parentID
        case storyID
        case children, options
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
}
}



extension Date {
    func offsetFrom(date : Date) -> String {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m" + " " + seconds
        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        let days = "\(difference.day ?? 0)d" + " " + hours
        
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }
}

extension UIView {
    func card() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.2
    }
}

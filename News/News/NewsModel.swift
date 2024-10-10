//
//  NewsModel.swift
//  News
//
//  Created by Momo on 29/6/2567 BE.
//

import Foundation

struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Codable, Identifiable {
    var id: UUID = UUID()
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
    var source: Source?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
        case source
    }
}

struct Source: Codable {
    var id: String?
    var name: String?
}

struct NewsCategory {
    var category: String
    var articles: [Article]
}

struct ErrorResponse: Codable {
    var status: String
    var code: String
    var message: String
}

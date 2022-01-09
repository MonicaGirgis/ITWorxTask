//
//  Article.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import Foundation


// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var date: Date?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, url, urlToImage, publishedAt, content, date
        case articleDescription = "description"
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?
}

//
//  NewsModel.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let news: [News]
}

// MARK: - News
struct News: Codable {
    let id: Int
    let title, newsDescription, date: String
    let link: String
    let picUrl: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case newsDescription = "description"
        case date, link, picUrl
    }
}

//
//  ArticlesNews.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import Foundation

struct ArticlesNews: Codable {
  let urlToImage: String
  let title: String
  let publishedAt: Date
  let source: Source?
  let description: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case urlToImage
    case title
    case publishedAt
    case source
    case description
    case url
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    let publishedAtString = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
    publishedAt = publishedAtString.date(format: .dateTimeISO8601) ?? Date(timeIntervalSince1970: 0)
    source = try container.decodeIfPresent(Source.self, forKey: .source)
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
  }
}

//
//  RootNews.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import Foundation

struct RootNews: Codable {
  let articles: [ArticlesNews]
  
  enum CodingKeys: String, CodingKey {
    case articles
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    articles = try container.decodeIfPresent([ArticlesNews].self, forKey: .articles) ?? []
  }
}

//
//  SourceNews.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import Foundation

struct Source: Codable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
  }
}

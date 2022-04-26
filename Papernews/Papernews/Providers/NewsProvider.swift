//
//  NewsProvider.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import Foundation
import Alamofire

private var apiKey: String {
  get {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }
    return value
  }
}

private let baseUrl = "https://newsapi.org/v2"

class NewsProvider {
  static let shared: NewsProvider = NewsProvider()
  private init() { }
  
  func loadTopNews(completion: @escaping (Result<[ArticlesNews], Error>) -> Void) {
    AF.request(
      "\(baseUrl)/top-headlines",
      method: .get,
      parameters: [
        "country": "id",
        "apiKey": apiKey
      ]
    ).response { dataResponse in
      if let data = dataResponse.data {
        do {
          let response = try JSONDecoder().decode(RootNews.self, from: data)
          completion(.success(response.articles))
        } catch {
          completion(.failure(error))
        }
      } else {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Oops! Something went wrong"])
        completion(.failure(error))
      }
    }
  }
}

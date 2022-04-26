//
//  DateExtensions.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import Foundation

extension Date {
  var valueDefaultDate: Date {
    return Date(timeIntervalSince1970: 0)
  }
  
  func string(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}

//
//  Date+Extensions.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

extension DateFormatter {
  static func convertDateStringToDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    if let date = dateFormatter.date(from: dateString) {
      return formattedDateString(from: date, format: "dd-MM-yyyy")
    } else {
      return "\(Date())"
    }
  }

  static func formattedDateString(from date: Date, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }
}

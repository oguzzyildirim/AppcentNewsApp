//
//  String+Extensions.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation

extension String {
  func trimmed() -> String {
    self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func removeAfterCharacter(_ character: Character) -> String {
    if let range = self.range(of: String(character)) {
      let substring = self[..<range.lowerBound]
      return String(substring)
    } else {
      return self
    }
  }

  func convertToDate(from dateString: String) -> Date {
    let dateFormatter = ISO8601DateFormatter()
    if let date = dateFormatter.date(from: dateString) {
      return date
    } else {
      return Date()
    }
  }
}

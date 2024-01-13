//
//  DBFavorite.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

struct DBFavorite: Codable, Identifiable, Equatable {
  static func == (lhs: DBFavorite, rhs: DBFavorite) -> Bool {
    return lhs.id == rhs.id
  }

  var id: String { return UUID().uuidString}
  var favorite: Article

}

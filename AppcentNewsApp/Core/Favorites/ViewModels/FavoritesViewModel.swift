//
//  FavoritesViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
  var userManager: UserManager
  @Published var favorites: [DBFavorite] = []
  @Published var doesExist: Bool = false
  @Published var alertMessage = ""
  @Published var showAlert = false

  init(userManager: UserManager) {
    self.userManager = userManager
  }

  func createNewsFavorite(news: Article, isFavorite: Bool) async throws {
    let dbfavorite = DBFavorite(favorite: news)
    try await userManager.createNewFavorite(favorite: dbfavorite)
  }

  func loadFavorites() async throws {
    guard let favorites = try await userManager.getFavorites() else {
      throw URLError(.badURL)
    }
    self.favorites = favorites
  }

  func doesFavoriteExist(favoriteIsExist: DBFavorite) -> Bool {
    if !self.favorites.isEmpty{
      for favorite in favorites {
        if favoriteIsExist.favorite._title == favorite.favorite._title {
          self.alertMessage = "The article is already in your favorites. It has been removed."
          self.doesExist = true
        } else {
          self.alertMessage = "Added to favorites."
          self.doesExist = false
        }
      }
    }
    else {
      self.alertMessage = "Added to favorites."
      self.doesExist = false
    }
    self.showAlert = true
    return self.doesExist
  }

  func deleteFavoriteFromFirestore(favorite: Article) async throws {
    try await userManager.removeNewFromFavorites(favorite: favorite)
  }

  func deleteFavoriteFromFavorites(favorite: Article) async throws {
    try await userManager.deleteFavoriteFromFavorites(title: favorite._title)
  }

}

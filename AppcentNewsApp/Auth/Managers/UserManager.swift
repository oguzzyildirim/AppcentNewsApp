//
//  UserManager.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserManagerProtocol {
    func createNewUser(user: DBUser, userName: String) async throws
    func getUser(userId: String) async throws -> DBUser
    func createNewFavorite(favorite: DBFavorite) async throws
    func getFavorites() async throws -> [DBFavorite]?
    func removeNewFromFavorites(favorite: Article) async throws
    func deleteFavoriteFromFavorites(title: String) async throws
}

final class UserManager: UserManagerProtocol {
  var authManager: AuthManager
  init(authManager: AuthManager) {
    self.authManager = authManager
  }

  private let userCollection = Firestore.firestore().collection("users")

  private func userDocument(userId: String) -> DocumentReference {
    userCollection.document(userId)
  }

  func createNewUser(user: DBUser, userName: String) async throws {
    var userWithUserName = user
    userWithUserName.userName = userName
    try userDocument(userId: user.userId).setData(from: userWithUserName, merge: false)
  }

  func getUser(userId: String) async throws -> DBUser {
    try await userDocument(userId: userId).getDocument(as: DBUser.self)
  }

  func createNewFavorite(favorite: DBFavorite) async throws {
    let authDataResult = try await authManager.getAuthenticatedUser()


    try userDocument(userId: authDataResult.uid).collection("favorites").document(favorite.favorite._title).setData(from: favorite, merge: false)

  }

  func getFavorites() async throws -> [DBFavorite]? {
    let authDataResult = try await authManager.getAuthenticatedUser()

    do {
      let favoritesData = try await userDocument(userId: authDataResult.uid)
        .collection("favorites")
        .getDocuments()

      let favorites: [DBFavorite] = try favoritesData.documents.map { document in
        return try document.data(as: DBFavorite.self)
      }

      return favorites
    } catch {
      print("Document not found: \(error)")
      return nil
    }
  }

  func removeNewFromFavorites(favorite: Article) async throws {
      let authDataResult = try await authManager.getAuthenticatedUser()

      try await userDocument(userId: authDataResult.uid)
          .collection("favorites")
          .document(favorite._title)
          .delete()
  }

  func deleteFavoriteFromFavorites(title: String) async throws {
    let authDataResult = try await authManager.getAuthenticatedUser()

    try await userDocument(userId: authDataResult.uid)
        .collection("favorites")
        .document(title)
        .delete()
  }
}


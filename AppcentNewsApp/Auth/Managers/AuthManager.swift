//
//  AuthManager.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
  func getAuthenticatedUser() async throws -> AuthDataResultModel

  @discardableResult
  func createUser(email: String, password: String) async throws -> AuthDataResultModel

  @discardableResult
  func signInUser(email: String, password: String) async throws -> AuthDataResultModel

  func signOut() throws
}

@MainActor
final class AuthManager: AuthManagerProtocol {
  func getAuthenticatedUser() async throws -> AuthDataResultModel {
    guard let user = Auth.auth().currentUser else {
      // MARK: Create custom errors!
      throw URLError(.badServerResponse)
    }

    return AuthDataResultModel(user: user)
  }

  @discardableResult
  func createUser(email: String, password: String) async throws -> AuthDataResultModel {
    let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
    return AuthDataResultModel(user: authDataResult.user)
  }

  @discardableResult
  func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
    let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
    return AuthDataResultModel(user: authDataResult.user)
  }

  nonisolated func signOut() throws {
    try Auth.auth().signOut()
  }
}


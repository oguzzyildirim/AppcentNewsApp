//
//  SettingsViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
  var authManager: AuthManager

  init(authManager: AuthManager) {
    self.authManager = authManager
  }

  func signOut() throws {
    try authManager.signOut()
  }
}

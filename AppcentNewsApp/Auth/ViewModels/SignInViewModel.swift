//
//  SignInViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

public protocol SignInViewModelProtocol {
    func signIn() async throws
}

@MainActor
final class SignInViewModel: ObservableObject, SignInViewModelProtocol {
  var authManager: AuthManager

  @Published var email = ""
  @Published var password = ""
  @Published var showAlert = false
  @Published var alertMessage = ""

  init(authManager: AuthManager) {
    self.authManager = authManager
  }

  // MARK: - Validation logics here

  private var isInputValid: Bool {
    return isValidEmail(email) && isValidPassword(password)
  }

  private func isValidEmail(_ email: String) -> Bool {
 
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }

  private func isValidPassword(_ password: String) -> Bool {
    let minimumLength = 6
    let containsLetter = password.rangeOfCharacter(from: .letters) != nil
    return password.count >= minimumLength && containsLetter
  }

  // MARK: - FirebaseAuth logics here


  func signIn() async throws {
    do {
      guard isInputValid else {

        throw URLError(.badServerResponse)
      }
      try await authManager.signInUser(email: email, password: password)
    } catch {
      alertMessage = "Please enter a valid email and password"
      showAlert = true
      throw URLError(.badServerResponse)
    }
  }

  func setAuthVariablesToEmpty() {
    self.email = ""
    self.password = ""
  }
}

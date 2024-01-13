//
//  SignUpViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
  var authManager: AuthManager
  var userManager: UserManager
  @Published var email = ""
  @Published var password = ""
  @Published var userName = ""
  @Published var passwordIsCorrect = ""
  @Published var showAlert = false
  @Published var alertMessage = ""

  // MARK: - Validation logics here
  init(authManager: AuthManager, userManager: UserManager) {
    self.authManager = authManager
    self.userManager = userManager
  }

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

  func signUp() async throws {
    do {
      guard isInputValid && checkPassword else {
        throw URLError(.badServerResponse)
      }

      var authDataResult = try await authManager.createUser(email: email, password: password)
      authDataResult.userName = self.userName

      let user = DBUser(auth: authDataResult)
      try await userManager.createNewUser(user: user, userName: self.userName)

    } catch {
      if !checkPassword {
        alertMessage = "Please double-check the entered passwords"
      } else {
        alertMessage = "Please enter a valid email and password"
      }
      showAlert = true
      throw URLError(.badServerResponse)
    }
  }

  private var checkPassword: Bool {
    return password == passwordIsCorrect
  }
}

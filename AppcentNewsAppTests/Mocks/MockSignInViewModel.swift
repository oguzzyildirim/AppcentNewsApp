//
//  MockSignInViewModel.swift
//  AppcentNewsAppTests
//
//  Created by Oğuz Yıldırım on 12.01.2024.
//

import Foundation
import AppcentNewsApp


final class MockSignInViewModel {
  var email = ""
  var password = ""


  var isInputValid: Bool {
    return isValidEmail(email) && isValidPassword(password)
  }

  func isValidEmail(_ email: String) -> Bool {

    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }

  func isValidPassword(_ password: String) -> Bool {
    let minimumLength = 6
    let containsLetter = password.rangeOfCharacter(from: .letters) != nil
    return password.count >= minimumLength && containsLetter
  }

}

//
//  SignInViModel_Test.swift
//  AppcentNewsAppTests
//
//  Created by Oğuz Yıldırım on 12.01.2024.
//

import XCTest
@testable import AppcentNewsApp

final class SignInViewModel_Test: XCTestCase {
  var signInViewModel: MockSignInViewModel!

  @MainActor
  override func setUpWithError() throws {
    super.setUp()
    signInViewModel = MockSignInViewModel()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    signInViewModel = nil
    try super.tearDownWithError()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_SignInViewModel_isValidEmail_shouldBeTrue() {
    //Given
    signInViewModel.email  = "testing@testing.com"
    signInViewModel.password = "1234aa"
    //When

    //Then
    XCTAssertTrue(signInViewModel.isInputValid)
  }

}

//
//  NetworkManager_Tests.swift
//  AppcentNewsAppTests
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import XCTest
import Alamofire
@testable import AppcentNewsApp

final class NetworkManager_Tests: XCTestCase {
  var networkManager: NetworkManager!

  override func setUpWithError() throws {
    super.setUp()
    let realReachabilityManager = NetworkReachabilityManager()!
    networkManager = NetworkManager(reachabilityManager: realReachabilityManager)

  }

  override func tearDownWithError() throws {
    networkManager = nil
    super.tearDown()
  }

  func test_NetworkManager_isConnectedToInternet_shoulBeTrueWhenReachable() {
    // Given

    // When
    let isConnected = networkManager.isConnectedToInternet()
    // Then
    XCTAssertTrue(isConnected)
  }

  func test_NetworkManager_request_shouldBeSuccess() {
    // Given
    let expectation = XCTestExpectation(description: "API Request Expectation")

    // When
    networkManager.request(Router.search(q: "besiktas", page: "1", apiKey: "90801f6001934745b7c544c54962e89d", pageSize: "6"), decodeToType: NewModel.self) { result in
      switch result {
      case .success(let decodedObject):
        // Then
        XCTAssertNotNil(decodedObject)
        expectation.fulfill()

      case .failure(let error):
        XCTFail("NetworkManager request failed with error: \(error)")
      }
    }

    // Wait for the expectation to be fulfilled
    wait(for: [expectation], timeout: 5)
  }

  func test_NetworkManager_request_shoulBeFailureWhenApiKeyInvalid() {
    // Given
    let invalidApiKey = UUID().uuidString

    // When
    networkManager.request(Router.search(q: "besiktas", page: "1", apiKey: "\(invalidApiKey)", pageSize: "6"), decodeToType: NewModel.self) { result in
      switch result {
      case .success(let decodedObject):
        // Then
        XCTAssertNil(decodedObject)

      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
  }


}

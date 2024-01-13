//
//  CustomTabViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation

final class CustomTabViewModel: ObservableObject {
  private var newService: NewServiceProtocol

  init(newService: NewServiceProtocol) {
    self.newService = newService
  }
  @Published var selectedTab: CustomTabEnum.Tab = .house
}

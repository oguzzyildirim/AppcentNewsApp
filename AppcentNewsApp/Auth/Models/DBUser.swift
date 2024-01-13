//
//  DBUser.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

struct DBUser: Codable {
  let userId: String
  var userName: String?
  let email: String?
  
  init(auth: AuthDataResultModel) {
    self.userId = auth.uid
    self.userName = auth.userName
    self.email = auth.email
  }

  init(userId: String, userName: String, email: String) {
    self.userId = userId
    self.userName = userName
    self.email = email
  }
  
  enum CodingKeys: String, CodingKey {
    case userId = "user_id"
    case userName = "user_name"
    case email = "email"
  }
}

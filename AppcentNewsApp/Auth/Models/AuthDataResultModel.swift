//
//  AuthDataResultModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import Foundation

import FirebaseAuth

struct AuthDataResultModel {
  let uid: String
  var userName: String?
  let email: String?

  init(user: User) {
    self.uid = user.uid
    self.userName = user.displayName
    self.email = user.email
  }

  init(uid: String, userName: String? = nil, email: String?) {
    self.uid = uid
    self.userName = userName
    self.email = email
  }
}

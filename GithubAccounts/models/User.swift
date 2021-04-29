//
//  User.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Foundation

class User: Codable {
  
  var username: String
  var avatarUrl: String
  
  private enum CodingKeys: String, CodingKey {
    case username = "login"
    case avatarUrl = "avatar_url"
  }
}

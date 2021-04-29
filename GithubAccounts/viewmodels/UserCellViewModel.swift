//
//  UserCellViewModel.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Foundation

class UserCellViewModel {
  
  var username: String { return "@\(user?.username ?? "")" }
  
  var avatarUrl: URL? { return URL(string: user?.avatarUrl ?? "") }
  
  private var user: User?
  
  init(_ user: User) {
    self.user = user
  }
}

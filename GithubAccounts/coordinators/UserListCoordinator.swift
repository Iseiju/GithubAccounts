//
//  UserListCoordinator.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Foundation
import UIKit

class UserListCoordinator {
  
  var presentedController: UIViewController?
  
  convenience init(_ presentedController: UIViewController) {
    self.init()
    self.presentedController = presentedController
  }
  
  func presentUserList() {
    guard let userListController = R.storyboard.main.userListController() else { return }
    userListController.viewModel = UserListViewModel()
    
    let navController = UINavigationController(rootViewController: userListController)
    navController.navigationBar.prefersLargeTitles = true
    navController.modalPresentationStyle = .fullScreen
    
    presentedController?.present(navController, animated: true, completion: nil)
  }
}

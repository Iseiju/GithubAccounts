//
//  LandingController.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import UIKit

class LandingController: UIViewController {

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startAnimation()
    toMainScreen()
  }

  private func startAnimation() {
    UIView.animate(withDuration: 0.4) { [weak self] in
      self?.activityIndicator.isHidden = false
      self?.activityIndicator.startAnimating()
    }
  }

  private func toMainScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      guard let s = self else { return }
      let userListCoordinator = UserListCoordinator(s)
      userListCoordinator.presentUserList()
    }
  }
}

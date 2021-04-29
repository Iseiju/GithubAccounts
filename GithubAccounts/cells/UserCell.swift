//
//  UserCell.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Kingfisher
import UIKit

class UserCell: UITableViewCell {
  
  private var cellViewModel: UserCellViewModel?

  @IBOutlet weak var avatarImageView: UIImageView!
  
  @IBOutlet weak var usernameLabel: UILabel!
  
  func set(_ cellViewModel: UserCellViewModel) {
    self.cellViewModel = cellViewModel
    
    avatarImageView.kf.indicatorType = .activity
    avatarImageView.kf.setImage(with: self.cellViewModel?.avatarUrl,
                                placeholder: R.image.icPlaceholder(),
                                options: [.transition(.fade(0.2))])
    
    usernameLabel.text = self.cellViewModel?.username
  }
}

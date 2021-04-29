//
//  UserListController.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import RxCocoa
import RxSwift
import UIKit

class UserListController: UIViewController {
  
  var viewModel: UserListViewModel?

  private let disposeBag = DisposeBag()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    refreshControl.tintColor = R.color.activityIndicatorColor()
    return refreshControl
  }()
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var activityIndicatorView: UIView!
  
  @IBOutlet weak var errorStackView: UIStackView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var tryAgainButton: UIButton!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    getUsers()
    initObservables()
  }
  
  private func initViews() {
    navigationItem.title = "GitHub DM"
    
    tableView.delegate = self
    tableView.register(R.nib.userCell)
    tableView.refreshControl = refreshControl
  }
  
  private func getUsers() {
    showActivityIndicator()
    
    viewModel?.getUsers(completion: { [weak self] isSuccess, errorOrNil in
      if isSuccess {
        self?.hideActivityIndicator()
      } else {
        self?.showErrorMessage(title: "Something went wrong",
                               message: errorOrNil?.localizedDescription ?? "")
      }
    })
  }
  
  @objc private func refreshList() {
    refreshControl.beginRefreshing()
    
    viewModel?.getUsers(completion: { [weak self] _, _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        self?.refreshControl.endRefreshing()
      }
    })
  }
  
  private func initObservables() {
    viewModel?
      .cellViewModels()
      .bind(to: tableView
              .rx
              .items(cellIdentifier: R.nib.userCell.identifier,
                     cellType: UserCell.self)) { index, cellViewModel, cell in
        cell.set(cellViewModel)
        cell.layoutIfNeeded()
      }.disposed(by: disposeBag)
  }
  
  private func showActivityIndicator() {
    activityIndicatorView.isHidden = false
    errorStackView.isHidden = true
    activityIndicator.startAnimating()
  }
  
  private func hideActivityIndicator() {
    activityIndicator.stopAnimating()
    activityIndicatorView.isHidden = true
  }
  
  private func showErrorMessage(title: String, message: String) {
    activityIndicator.stopAnimating()
    errorStackView.isHidden = false
    
    titleLabel.text = title
    messageLabel.text = message
  }
  
  @IBAction func didTapTryAgain(_ sender: Any) {
    getUsers()
  }
}

extension UserListController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

//
//  UserListViewModel.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Foundation
import RxCocoa
import RxSwift

class UserListViewModel {
  
  private let disposeBag = DisposeBag()
  
  private let userList = BehaviorRelay<[User]>(value: [])

  func getUsers(completion: @escaping (_ isSuccess: Bool, _ errorOrNil: Error?) -> Void) {
    let url = "https://api.github.com/users"
    
    APIClient.shared.getRequest(url, model: [User].self, completion: { response in
      switch response.result {
      case .success(let users):
        self.userList.accept(users)
        completion(true, nil)
        
      case .failure(let error as Error):
        completion(false, error)
      }
    })
  }
  
  func cellViewModels() -> BehaviorRelay<[UserCellViewModel]> {
    let cellViewModels = BehaviorRelay<[UserCellViewModel]>(value: [])
    
    userList.subscribe(onNext: { user in
      cellViewModels.accept(user.map { user in
        return UserCellViewModel(user)
      })
    }).disposed(by: disposeBag)
    
    return cellViewModels
  }
}

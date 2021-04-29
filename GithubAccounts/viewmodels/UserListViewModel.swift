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
  
  private var id = 0
  
  private let disposeBag = DisposeBag()
  
  private let userList = BehaviorRelay<[User]>(value: [])

  func getUsers(completion: @escaping (_ isSuccess: Bool,
                                       _ canLoadMore: Bool,
                                       _ errorOrNil: Error?) -> Void) {
    let url = "https://api.github.com/users?since=\(id)"
    
    APIClient.shared.getRequest(url, model: [User].self, completion: { response in
      switch response.result {
      case .success(let users):
        if self.id == 0 {
          self.userList.accept(users)
        } else {
          var userList = self.userList.value
          userList.append(contentsOf: users)
          
          self.userList.accept(userList)
        }
        
        print("USER ID: \(users.last?.id)")
        self.id = users.last?.id ?? 0
        
        completion(true, true, nil)
        
      case .failure(let error as Error):
        print(error.asAFError?.errorDescription)
        print(error.asAFError?.localizedDescription)
        completion(false, false, error)
      }
    })
  }
  
  func userCount() -> Int {
    return userList.value.count
  }
  
  func resetId() {
    id = 0
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

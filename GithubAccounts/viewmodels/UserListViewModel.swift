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
                                       _ errorOrNil: NSError?) -> Void) {
    let url = "https://api.github.com/users?since=\(id)"
    
    APIClient
      .shared
      .getRequest(url,
                  model: [User].self,
                  completionHandler: { response in
                    if self.id == 0 {
                      self.userList.accept(response)
                    } else {
                      var userList = self.userList.value
                      userList.append(contentsOf: response)
                      
                      self.userList.accept(userList)
                    }
                    
                    self.id = response.last?.id ?? 0
                    
                    completion(true, true, nil)
                    
                  }, errorHandler: { error in
                    completion(false, false, error)
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

# GithubAccounts
An iOS app that shows a list of GitHub users

Endpoint: https://api.github.com/users

# UI and Design
For the UI and Design, I went with a standard table list in the Main User List screen, and `prefersLargeTitles` set to `true` for the Main UINavigationController.

# Architecture: RxMVVM-C
My architectural pattern of choice is RxMVVM-C and the choice was made over the standard MVC pattern of Apple.

Since Apple's MVC tends to get bloated as the project grows, 
it's much harder to maintain a codebase wherein the Views are heavily dependent on both Controllers and a Models,
thus having no clear distinction in the responsibilities of who controls the UI logic.

By implementing MVVM to this app, the ViewModel becomes the middleman between the Model and the View. 
It populates the UI elements of a View with the necessary data and it also interacts with the Model to set up the data.
This results in a more clearer distinction in the responsibilities. 

## RxSwift

I've also implemented RxSwift to the overall architectural pattern for biding my ViewModels to my TableView.
By binding the ViewModels to the TableView, the app can listen and adapt to any changes made to the cells and its data.

## Navigation - Coordinator Pattern
In this app, the Coordinator handles the navigation in between controllers/screens.

This is my preferred method of transition to other controllers rather than through segues because of its flexibility, configurability, and reusability of screens.

Please see `UserListCoordinator.swift` for reference.

# Additional Optional Specification

- Dark Mode
- iPad Support (via varying constraints)
- App Icon
- Avatar placeholders
- Pagination
- Pull-to-Refresh

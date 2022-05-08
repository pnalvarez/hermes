//
//  RepoDetailsViewModel.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

protocol RepoDetailsViewModelContract {
  var repo: RepoDetailsView.ViewModel { get }
  func fetchInfo()
}

final class RepoDetailsViewModel: RepoDetailsViewModelContract {
  private var repoDetails: RepositoryDetails
  
  var repo: RepoDetailsView.ViewModel {
    .init(name: "Name: \(repoDetails.name)",
          url: "URL: \(repoDetails.url)",
          stars: "Stars: \(repoDetails.stargazers.totalCount)",
          ownerName: repoDetails.owner.login,
          ownerImage: repoDetails.owner.avatarUrl)
  }
  
  weak var viewController: RepoDetailsDisplaying?
  
  init(repositoryDetails: RepositoryDetails) {
    self.repoDetails = repositoryDetails
  }
  
  func fetchInfo() {
    viewController?.updateUI()
  }
}


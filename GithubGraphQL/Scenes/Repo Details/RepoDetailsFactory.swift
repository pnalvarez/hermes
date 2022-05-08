//
//  RepoDetailsFactory.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

enum RepoDetailsFactory {
  static func build(repositoryDetails: RepositoryDetails) -> RepoDetailsViewController {
    let viewModel = RepoDetailsViewModel(repositoryDetails: repositoryDetails)
    let viewController = RepoDetailsViewController(viewModel: viewModel)
    viewModel.viewController = viewController
    return viewController
  }
}

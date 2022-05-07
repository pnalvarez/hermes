//
//  RepoListFactory.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

enum RepoListFactory {
  static func build() -> RepoListViewController {
    let viewModel = RepoListViewModel()
    let viewController = RepoListViewController(viewModel: viewModel)
    return viewController
  }
}

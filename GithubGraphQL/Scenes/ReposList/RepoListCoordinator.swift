//
//  RepoListCoordinator.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

protocol RepoListCoordinatorContract {
  func routeToDetails(repositoryDetails: RepositoryDetails)
}

final class RepoListCoordinator {
  weak var viewController: UIViewController?
  
}

extension RepoListCoordinator: RepoListCoordinatorContract {
  func routeToDetails(repositoryDetails: RepositoryDetails) {
    let detailsVC = RepoDetailsFactory.build(repositoryDetails: repositoryDetails)
    viewController?.navigationController?.pushViewController(detailsVC,
                                                             animated: true)
  }
}

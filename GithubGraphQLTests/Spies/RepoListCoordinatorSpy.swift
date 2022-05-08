//
//  RepoListCoordinatorSpy.swift
//  GithubGraphQLTests
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

@testable import GithubGraphQL

final class RepoListCoordinatorSpy: RepoListCoordinatorContract {
  private(set) var routeToDetailsCallsCount: Int = 0
  private(set) var repositoryDetails: RepositoryDetails?
  
  func routeToDetails(repositoryDetails: RepositoryDetails) {
    routeToDetailsCallsCount += 1
    self.repositoryDetails = repositoryDetails
  }
}

//
//  RepoListViewControllerSpy.swift
//  GithubGraphQLTests
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

@testable import GithubGraphQL

final class RepoListViewControllerSpy: RepoListDisplaying {
  private(set) var updateUICallsCount: Int = 0
  private(set) var displayErrorCallsCount: Int = 0
  private(set) var displayLoadingCallsCount: Int = 0
  private(set) var errorMessage: String?
  
  func updateUI() {
    updateUICallsCount += 1
  }
  
  func displayLoading(_ loading: Bool) {
    displayLoadingCallsCount += 1
  }
  
  func displayError(_ message: String) {
    displayLoadingCallsCount += 1
    errorMessage = message
  }
}

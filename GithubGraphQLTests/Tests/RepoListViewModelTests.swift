//
//  RepoListViewModelTests.swift
//  GithubGraphQLTests
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import XCTest
@testable import GithubGraphQL

class RepoListViewModelTests: XCTestCase {
  
  var sut: RepoListViewModel?

  override func tearDown() {
    sut = nil
  }
  
  func testViewDidLoad_WhenResponseIsSuccess_ShouldCallUpdateUI() {
    let viewControllerSpy = RepoListViewControllerSpy()
    let coordinatorSpy = RepoListCoordinatorSpy()
    let dependencyContainerMock = ReposListDependencyContainerMock(client: MockGraphQLClient<SearchRepositoriesQuery>(response: SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: 3)
    ))))
    sut = RepoListViewModel(dependencies: dependencyContainerMock,
                            coordinator: coordinatorSpy)
    sut?.viewController = viewControllerSpy
    sut?.viewDidLoad()
    XCTAssertEqual(viewControllerSpy.displayLoadingCallsCount, 2)
    XCTAssertEqual(viewControllerSpy.updateUICallsCount, 1)
    XCTAssertEqual(sut?.totalRepos, 3)
    XCTAssertEqual(sut?.reposInterface.count, 3)
  }
  
  func testWillDisplayCell_WhenCellIndexIsLastOneFetched_ShouldCallUpdateUICallTwice() {
    let viewControllerSpy = RepoListViewControllerSpy()
    let coordinatorSpy = RepoListCoordinatorSpy()
    let dependencyContainerMock = ReposListDependencyContainerMock(client: MockGraphQLClient<SearchRepositoriesQuery>(response: SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: 3)
    ))))
    sut = RepoListViewModel(dependencies: dependencyContainerMock,
                            coordinator: coordinatorSpy)
    sut?.viewController = viewControllerSpy
    sut?.viewDidLoad()
    sut?.willDisplayCell(index: 2)
    XCTAssertEqual(sut?.reposInterface.count, 3)
    XCTAssertEqual(viewControllerSpy.updateUICallsCount, 2)
  }
  
  func testWillDisplayCell_WhenCellIndexIsFetched_ShouldCallUpdateUICallOnce() {
    let viewControllerSpy = RepoListViewControllerSpy()
    let coordinatorSpy = RepoListCoordinatorSpy()
    let dependencyContainerMock = ReposListDependencyContainerMock(client: MockGraphQLClient<SearchRepositoriesQuery>(response: SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: 3)
    ))))
    sut = RepoListViewModel(dependencies: dependencyContainerMock,
                            coordinator: coordinatorSpy)
    sut?.viewController = viewControllerSpy
    sut?.viewDidLoad()
    sut?.willDisplayCell(index: 1)
    XCTAssertEqual(sut?.reposInterface.count, 3)
    XCTAssertEqual(viewControllerSpy.updateUICallsCount, 1)
  }
  
  func testDidSelectCell() {
    let viewControllerSpy = RepoListViewControllerSpy()
    let coordinatorSpy = RepoListCoordinatorSpy()
    let dependencyContainerMock = ReposListDependencyContainerMock(client: MockGraphQLClient<SearchRepositoriesQuery>(response: SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: 3)
    ))))
    sut = RepoListViewModel(dependencies: dependencyContainerMock,
                            coordinator: coordinatorSpy)
    sut?.viewController = viewControllerSpy
    sut?.viewDidLoad()
    sut?.didSelectCell(index: 0)
    XCTAssertEqual(coordinatorSpy.routeToDetailsCallsCount, 1)
    XCTAssertNotNil(coordinatorSpy.repositoryDetails)
  }
}

//
//  ReposListDependencyContainerMock.swift
//  GithubGraphQLTests
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import Foundation
@testable import GithubGraphQL

final class ReposListDependencyContainerMock: HasMainQueue,
                                              HasGraphQLClient {
  lazy var mainQueue: DispatchQueue = .main
  var client: GraphQLClient
  
  init(client: GraphQLClient) {
    self.client = client
  }
}

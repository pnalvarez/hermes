//
//  DependencyContainer.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import Foundation
import Apollo

protocol HasMainQueue {
  var mainQueue: DispatchQueue { get set }
}

protocol HasGraphQLClient {
  var client: GraphQLClient { get set }
}

protocol HasNoDependency { }

final class DependencyContainer: HasMainQueue,
                                 HasGraphQLClient,
                                 HasNoDependency {
  lazy var mainQueue: DispatchQueue = .main
  lazy var client: GraphQLClient = ApolloClient.shared
}

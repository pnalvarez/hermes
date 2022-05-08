//
//  RepoListDataSource.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

final class RepoListDataSource: NSObject {
  private var totalRepos: Int = 0
  private var repos: [RepositoryDetails] = []
  private let tableView: UITableView
  
  init(tableView: UITableView) {
    self.tableView = tableView
  }
  
  func setUp(repos: [RepositoryDetails]) {
    self.repos = repos
  }
  
  func setUp(totalRepos: Int) {
    self.totalRepos = totalRepos
  }
}

extension RepoListDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    totalRepos
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row > totalRepos - 1 {
      let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                               type: LoadingTableViewCell.self)
      return cell
    }
    let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                             type: ReposListTableViewCell.self)
    cell.setup(viewModel: .init(name: repos[indexPath.row].name,
                                url: repos[indexPath.row].url,
                                stars: String(format: Constants.starsFormat,
                                              "\(repos[indexPath.row].stargazers.totalCount)")))
    return cell
  }
}

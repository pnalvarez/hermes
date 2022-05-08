//
//  RepoListView.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit
import SnapKit

final class RepoListView: UIView {
  private unowned var tableView: UITableView
  private unowned var activityView: UIActivityIndicatorView
  
  init(frame: CGRect,
       tableView: UITableView,
       activityView: UIActivityIndicatorView) {
    self.tableView = tableView
    self.activityView = activityView
    super.init(frame: frame)
    createViewWithViewCode()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RepoListView: ViewCodeProtocol {
  func buildViewHierarchy() {
    addSubview(tableView)
    addSubview(activityView)
  }
  
  func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    activityView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func additionalConfiguration() {
    backgroundColor = .white
  }
}

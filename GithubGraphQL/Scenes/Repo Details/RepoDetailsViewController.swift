//
//  RepoDetailsViewController.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

protocol RepoDetailsDisplaying: AnyObject {
  func updateUI()
}

final class RepoDetailsViewController: UIViewController {
  private let viewModel: RepoDetailsViewModelContract
  
  private lazy var rootView: RepoDetailsView = RepoDetailsView()
  
  init(viewModel: RepoDetailsViewModelContract) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchInfo()
    title = "Details"
  }
}

extension RepoDetailsViewController: RepoDetailsDisplaying {
  func updateUI() {
    rootView.setup(viewModel: viewModel.repo)
  }
}

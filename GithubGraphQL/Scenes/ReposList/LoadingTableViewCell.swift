//
//  LoadingTableViewCell.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
  private lazy var activityView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.backgroundColor = .white
      view.tintColor = .blue
      view.hidesWhenStopped = true
      view.isHidden = true
      return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoadingTableViewCell: ViewCodeProtocol {
  func buildViewHierarchy() {
    addSubview(activityView)
  }
  
  func setupConstraints() {
    activityView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
        make.height.equalTo(120)
    }
  }
}

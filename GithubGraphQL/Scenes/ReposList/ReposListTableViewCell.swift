//
//  ReposListTableViewCell.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

final class ReposListTableViewCell: UITableViewCell {
  struct ViewModel {
    let name: String
    let url: String
    let stars: String
  }
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 4
    return view
  }()
  
  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.font = .boldSystemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  private lazy var urlLabel: UILabel = {
    let view = UILabel()
    view.font = .boldSystemFont(ofSize: 16)
    view.textColor = .systemBlue
    return view
  }()
  
  private lazy var starImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "star_icon")
    return view
  }()
  
  private lazy var starsLabel: UILabel = {
    let view = UILabel()
    view.font = .boldSystemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  private lazy var starsContainer: UIView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    createViewWithViewCode()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(viewModel: ViewModel) {
    nameLabel.text = viewModel.name
    urlLabel.text = viewModel.url
    starsLabel.text = viewModel.stars
  }
}

extension ReposListTableViewCell: ViewCodeProtocol {
  func buildViewHierarchy() {
    addSubview(stackView)
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(urlLabel)
    stackView.addArrangedSubview(starsContainer)
    starsContainer.addSubview(starImageView)
    starsContainer.addSubview(starsLabel)
  }
  
  func setupConstraints() {
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
    starImageView.snp.makeConstraints { make in
      make.height.width.equalTo(16)
      make.left.equalToSuperview()
      make.top.bottom.equalToSuperview().inset(8)
    }
    starsLabel.snp.makeConstraints { make in
      make.left.equalTo(starImageView.snp.right).offset(8)
      make.centerY.equalTo(starImageView)
    }
  }
}

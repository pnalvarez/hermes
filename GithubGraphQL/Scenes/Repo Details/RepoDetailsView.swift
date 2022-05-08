//
//  RepoDetailsView.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit
import SDWebImage

final class RepoDetailsView: UIView {
  struct ViewModel {
    let name: String
    let url: String
    let stars: String
    let ownerName: String
    let ownerImage: String
  }
  
  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  private lazy var urlLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16)
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
    view.font = .systemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  private lazy var ownerFixedLabel: UILabel = {
    let view = UILabel()
    view.text = "Owner:"
    view.font = .systemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  private lazy var ownerImageView: UIImageView = {
    let view = UIImageView()
    return view
  }()
  
  private lazy var ownerNameLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16)
    view.textColor = .black
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createViewWithViewCode()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    ownerImageView.layer.cornerRadius = ownerImageView.frame.width / 2
  }
  
  func setup(viewModel: ViewModel) {
    nameLabel.text = viewModel.name
    urlLabel.text = viewModel.url
    starsLabel.text = viewModel.stars
    ownerImageView.sd_setImage(with: URL(string: viewModel.ownerImage))
    ownerNameLabel.text = viewModel.ownerName
  }
}

extension RepoDetailsView: ViewCodeProtocol {
  func buildViewHierarchy() {
    addSubview(nameLabel)
    addSubview(urlLabel)
    addSubview(starsLabel)
    addSubview(starImageView)
    addSubview(ownerFixedLabel)
    addSubview(ownerNameLabel)
    addSubview(ownerImageView)
  }
  
  func setupConstraints() {
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
      make.left.equalToSuperview().inset(24)
    }
    urlLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(16)
      make.left.equalTo(nameLabel)
    }
    starImageView.snp.makeConstraints { make in
      make.top.equalTo(urlLabel.snp.bottom).offset(16)
      make.left.equalTo(urlLabel)
      make.height.width.equalTo(16)
    }
    starsLabel.snp.makeConstraints { make in
      make.left.equalTo(starImageView.snp.right).offset(24)
      make.centerY.equalTo(starImageView)
    }
    ownerFixedLabel.snp.makeConstraints { make in
      make.top.equalTo(starsLabel.snp.bottom).offset(32)
      make.left.equalTo(starImageView.snp.right)
    }
    ownerImageView.snp.makeConstraints { make in
      make.top.equalTo(ownerFixedLabel.snp.bottom).offset(16)
      make.left.equalTo(ownerFixedLabel)
      make.height.width.equalTo(32)
    }
    ownerNameLabel.snp.makeConstraints { make in
      make.left.equalTo(ownerImageView.snp.right).offset(24)
      make.centerY.equalTo(ownerImageView)
    }
  }
  
  func additionalConfiguration() {
    backgroundColor = .white
  }
}

//
//  ViewCodeProtocol.swift
//  GithubGraphQL
//
//  Created by Pedro Alvarez on 07/05/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

protocol ViewCodeProtocol {
  func buildViewHierarchy()
  func setupConstraints()
  func additionalConfiguration()
}

extension ViewCodeProtocol {
  //Making this step as optional in the case there is no configuration to be set
  func additionalConfiguration() { }
  
  //ViewCode pipeline
  func createViewWithViewCode() {
    buildViewHierarchy()
    setupConstraints()
    additionalConfiguration()
  }
}

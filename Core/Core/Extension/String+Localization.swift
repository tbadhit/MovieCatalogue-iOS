//
//  String+Localization.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Foundation

extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}

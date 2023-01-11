//
//  Result+Ext.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import RealmSwift

extension Results {

  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}

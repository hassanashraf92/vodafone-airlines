//
//  Dynamic.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

public class Bindable<T> {
  
  typealias Listener = (T?) -> ()
  
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: Listener?
  
  func bind(observer: @escaping Listener) {
    self.observer = observer
    observer(value)
  }
  
  init(_ v: T) {
    value = v
  }
  
}

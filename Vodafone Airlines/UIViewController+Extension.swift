//
//  UIViewController+Extension.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

extension UIViewController {
  
  func insertChildController(_ child: UIViewController, into parent: UIView) {
    child.willMove(toParent: self)
    self.addChild(child)
    child.view.frame = parent.bounds
    parent.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
}

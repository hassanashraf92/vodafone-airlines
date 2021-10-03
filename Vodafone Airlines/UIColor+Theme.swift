//
//  UIColor+Theme.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit.UIColor

extension UIColor {
  
  // MARK: Private
  fileprivate static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
      return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
  }
  
  fileprivate static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
      return rgba(r, g, b, 1.0)
  }
  
  //MARK: Public
  static let background = rgb(244, 244, 244)
  static let primary = rgb(230, 0, 0)
  static let border = rgb(204, 204, 204)
  static let mainText = rgb(51, 51, 51)
  static let primaryShadow = rgba(230, 0, 0, 0.3)
  static let grayShadow = rgba(0, 0, 0, 0.16)
  
}

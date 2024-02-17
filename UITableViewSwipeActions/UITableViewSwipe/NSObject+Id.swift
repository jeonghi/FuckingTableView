//
//  NSObject+Id.swift
//  UITableViewSwipe
//
//  Created by 쩡화니 on 2/17/24.
//

import UIKit

extension NSObject {
  static var identifier: String {
    String(describing: self)
  }
}

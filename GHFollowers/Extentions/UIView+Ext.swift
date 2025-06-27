//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 27/06/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

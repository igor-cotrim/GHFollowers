//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 16/06/25.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(follower: Follower) {
        contentConfiguration = UIHostingConfiguration {
            FollowerView(follower: follower)
        }
    }
}

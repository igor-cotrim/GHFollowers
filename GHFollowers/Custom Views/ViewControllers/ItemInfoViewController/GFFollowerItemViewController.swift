//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        itemInfoViewOne.setup(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.setup(itemInfoType: .following, withCount: user.following)
        actionButton.setup(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}

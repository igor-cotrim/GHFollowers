//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        itemInfoViewOne.setup(itemInfoType: .repositories, withCount: user.publicRepos)
        itemInfoViewTwo.setup(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.setup(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}

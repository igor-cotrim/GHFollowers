//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    private weak var delegate: GFRepoItemViewControllerDelegate!
    
    init(user: User, delegate: GFRepoItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

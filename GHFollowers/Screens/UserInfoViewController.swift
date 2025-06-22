//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 22/06/25.
//

import UIKit

class UserInfoViewController: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                print(userInfo)
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue
                )
            }
        }
    }
}

// MARK: - objc functions
extension UserInfoViewController {
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 22/06/25.
//

import UIKit

class UserInfoViewController: UIViewController {
    var username: String!
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue
                )
            }
        }
        buildViewHierarchy()
        buildConstraints()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(headerView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func add(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
}

// MARK: - objc functions
extension UserInfoViewController {
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

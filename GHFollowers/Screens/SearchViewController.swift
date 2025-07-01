//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 10/06/25.
//

import UIKit

class SearchViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Images.ghLogo
        return view
    }()
    
    private let usernameTextField: GFTextField = {
        let textField = GFTextField()
        return textField
    }()
    
    private let callToActionButton: GFButton = {
        let button = GFButton(color: .systemGreen, title: "Get Followers", systemImage: SFSymbols.followersButton!)
        return button
    }()
    
    private var isUsernameEntered: Bool {
        !usernameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        createDismissKeyboardTapGestureRecognizer()
        buildViewHierarchy()
        buildConstraints()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func buildViewHierarchy() {
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
    }
    
    private func buildConstraints() {
        let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: view.contentScaleFactor * 200),
            logoImageView.widthAnchor.constraint(equalToConstant: view.contentScaleFactor * 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func createDismissKeyboardTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    private func setup() {
        usernameTextField.delegate = self
        callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        
        return true
    }
}

// MARK: - objc functions

extension SearchViewController {
    @objc private func pushFollowerListViewController() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for on GitHub!")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        guard let usernameText = usernameTextField.text else { return }
        let followerListViewController = FollowerListViewController(username: usernameText)
        
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
}

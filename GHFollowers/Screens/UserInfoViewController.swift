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
    
    private let itemViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let itemViewOne: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let itemViewTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAligment: .center)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getUserInfo()
        buildViewHierarchy()
        buildConstraints()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(headerView)
        view.addSubview(itemViewStackView)
        itemViewStackView.addArrangedSubview(itemViewOne)
        itemViewStackView.addArrangedSubview(itemViewTwo)
        view.addSubview(dateLabel)
    }
    
    private func buildConstraints() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewStackView.heightAnchor.constraint(equalToConstant: itemHeight * 2),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewStackView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                    self.add(child: GFRepoItemViewController(user: user), to: self.itemViewOne)
                    self.add(child: GFFollowerItemViewController(user: user), to: self.itemViewTwo)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue
                )
            }
        }
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

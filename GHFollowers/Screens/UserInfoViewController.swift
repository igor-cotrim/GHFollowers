//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 22/06/25.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: UIViewController {
    var username: String!
    weak var delegate: UserInfoViewControllerDelegate!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        getUserInfo()
        buildViewHierarchy()
        buildConstraints()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(headerView, itemViewStackView, dateLabel)
        itemViewStackView.addArrangedSubview(itemViewOne)
        itemViewStackView.addArrangedSubview(itemViewTwo)
    }
    
    private func buildConstraints() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 210),
            
            itemViewStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewStackView.heightAnchor.constraint(equalToConstant: itemHeight * 2),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewStackView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue
                )
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        self.add(child: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(child: GFRepoItemViewController(user: user,delegate: self), to: self.itemViewOne)
        self.add(child: GFFollowerItemViewController(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    private func add(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
}

// MARK: - GFFollowerItemViewControllerDelegate & GFRepoItemViewControllerDelegate

extension UserInfoViewController: GFFollowerItemViewControllerDelegate, GFRepoItemViewControllerDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The provided URL is invalid")
            return
        }
        
        presentSafariViewController(url: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissViewController()
    }
}

// MARK: - objc functions

extension UserInfoViewController {
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

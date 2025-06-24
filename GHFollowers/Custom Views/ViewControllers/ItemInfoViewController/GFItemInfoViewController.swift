//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import UIKit

class GFItemInfoViewController: UIViewController {
    var user: User!
    weak var delegate: UserInfoViewControllerDelegate!
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let itemInfoViewOne: GFItemInfoView = {
        let view = GFItemInfoView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let itemInfoViewTwo: GFItemInfoView = {
        let view = GFItemInfoView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let actionButton: GFButton = {
        let button = GFButton()
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
        buildViewHierarchy()
        buildConstraints()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        view.addSubview(actionButton)
    }
    
    private func buildConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - objc methods
extension GFItemInfoViewController {
    @objc func actionButtonTapped() {}
}

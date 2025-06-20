//
//  GFAlertViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 11/06/25.
//

import UIKit

class GFAlertViewController: UIViewController {
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    let containertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 20)
        return label
    }()
    
    let messageLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAligment: .center)
        label.numberOfLines = 4
        return label
    }()
    
    let actionButton: GFButton = {
        let button = GFButton(backgroundColor: .systemPink, title: "Ok")
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        buildViewHierarchy()
        buildConstraints()
        setup()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(containertView)
        containertView.addSubview(titleLabel)
        containertView.addSubview(messageLabel)
        containertView.addSubview(actionButton)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            containertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containertView.widthAnchor.constraint(equalToConstant: 280),
            containertView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containertView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containertView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containertView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containertView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containertView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            
            actionButton.bottomAnchor.constraint(equalTo: containertView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containertView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containertView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setup() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        messageLabel.text = message ?? "Unable to complete request"
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
    }
}

// MARK: - @objc functions

extension GFAlertViewController {
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

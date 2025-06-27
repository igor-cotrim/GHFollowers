//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 23/06/25.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {
    var user: User!
    
    private let avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        return imageView
    }()
    
    private let usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 34)
        return label
    }()
    
    private let nameLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView(image: SFSymbols.location)
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    private let bioLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAligment: .left)
        label.numberOfLines = 3
        return label
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
        
        buildViewHierarchy()
        buildConstraints()
        setup()
    }
    
    private func buildViewHierarchy() {
        view.addSubviews(avatarImageView,
                         usernameLabel,
                         nameLabel,
                         locationImageView,
                         locationLabel,
                         bioLabel)
    }
    
    private func buildConstraints() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    private func setup() {
        downloadAvatarImage()
        
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No bio provided"
    }
    
    private func downloadAvatarImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
}

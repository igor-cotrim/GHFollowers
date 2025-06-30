//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 25/06/25.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseIdentifier = "FavoriteCell"
    
    private let avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        return imageView
    }()
    
    private let usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 26)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        
        buildViewHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubviews(avatarImageView, usernameLabel)
    }
    
    private func buildConstraints() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setup(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    }
}

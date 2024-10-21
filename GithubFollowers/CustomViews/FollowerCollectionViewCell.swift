//
//  FollowerCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 17/10/24.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    static let identifier = "FollowerCollectionViewCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let nameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        nameLabel.text = follower.login
        //avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        let padding: CGFloat = 8
        print("🚩🚩🚩 \(avatarImageView.widthAnchor)")
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

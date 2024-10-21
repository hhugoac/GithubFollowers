//
//  FollowerCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 17/10/24.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    static let identifier = "FollowerCollectionViewCell"
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avatar-placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        contentView.addSubviews(avatarImageView, nameLabel)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        nameLabel.text = follower.login
        //avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    private func configure() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ])
    }
}

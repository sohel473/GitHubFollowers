//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/14/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resuseID = "FollowerCell"
    let avaterImageView = GFAvaterImageView()
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avaterImageView.downloadImage(for: follower.avatar_url)
    }
    
    private func configure() {
        addSubview(avaterImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avaterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            avaterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            avaterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            avaterImageView.heightAnchor.constraint(equalTo: avaterImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

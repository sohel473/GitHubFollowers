//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/23/22.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let resuseID = "FavoriteCell"
    let avaterImageView = GFAvaterImageView()
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        accessoryType = .detailButton
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avaterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avaterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avaterImageView.widthAnchor.constraint(equalToConstant: 60),
            avaterImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

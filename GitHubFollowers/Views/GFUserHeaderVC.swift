//
//  GFUserHeaderVC.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/20/22.
//

import UIKit

class GFUserHeaderVC: UIViewController {
    
    let avaterImageView = GFAvaterImageView()
    let usernamLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)

    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        avaterImageView.downloadImage(for: user.avatar_url)
        usernamLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
    }
    
    func addSubView() {
        view.addSubview(avaterImageView)
        view.addSubview(usernamLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avaterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avaterImageView.widthAnchor.constraint(equalToConstant: 90),
            avaterImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernamLabel.topAnchor.constraint(equalTo: avaterImageView.topAnchor),
            usernamLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            usernamLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernamLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avaterImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avaterImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

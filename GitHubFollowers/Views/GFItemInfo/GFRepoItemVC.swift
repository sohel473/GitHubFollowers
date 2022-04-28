//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/21/22.
//

import UIKit

protocol GFRepoInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.public_repos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.public_gists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}

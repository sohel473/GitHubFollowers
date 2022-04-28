//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/21/22.
//

import UIKit

protocol GFFollowerInfoDelegate: AnyObject {
    func didTapGetFollower(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerInfoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .follower, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollower(for: user)
    }
}

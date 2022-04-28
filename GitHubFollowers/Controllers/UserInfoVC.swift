//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/20/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollower(for username: String)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate: UserInfoVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        getUserInfo()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneItem
//        title = username
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.configureUIElement(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "An Error ☹️", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElement(with user: User) {
        
        add(childVC: GFUserHeaderVC(user: user), to: self.headerView)
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        add(childVC: repoItemVC, to: self.itemViewOne)
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        add(childVC: followerItemVC, to: self.itemViewTwo)
        
        dateLabel.text = "Joined at \(user.created_at.displayDate())"
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        itemViewOne.backgroundColor = .systemRed
//        itemViewTwo.backgroundColor = .systemBlue
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: itemViewTwo.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: GFRepoInfoVCDelegate, GFFollowerInfoDelegate {
    func didTapGithubProfile(for user: User) {
        // Show safari view controller
        guard let url = URL(string: user.html_url) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(from: url)
    }
    
    func didTapGetFollower(for user: User) {
        // dismiss the VC and update FollowerListVC with new followers
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Follower", message: "This user has no follower! 😓", buttonTitle: "Ok")
            return
        }
        delegate?.didRequestFollower(for: user.login)
        dismiss(animated: true)
    }
}

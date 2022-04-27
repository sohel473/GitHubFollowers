//
//  FavoritesVC.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/12/22.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
        getFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        print("View will appear called")
        getFavorites()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
    }
    
    func getFavorites() {
        PersistanceManager.getFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let followers):
                //                print(self.favorites)
                //                print(followers)
                self.favorites = followers
                if self.favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites?\nAdd one from the followers list.", in: self.view)
                }
                else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "An Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}

//MARK: - TableView Delegate and Datasource

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID, for: indexPath) as! FavoriteCell
        cell.set(follower: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let follower = favorites[indexPath.row]
        
        let destVC = FollowerListVC(username: follower.login)
        navigationController?.pushViewController(destVC, animated: true)
        
        
        //        let destVC = UserInfoVC()
        //        destVC.username = follower.login
        //        destVC.delegate = self
        //        let navController = UINavigationController(rootViewController: destVC)
        //        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite  = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(follower: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "An error", message: error.rawValue, buttonTitle: "Ok")
            
        }
    }
}

//extension FavoritesListVC: UserInfoVCDelegate {
//    func didRequestFollower(for username: String) {
//        <#code#>
//    }
//}

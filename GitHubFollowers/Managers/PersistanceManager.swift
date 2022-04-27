//
//  PersistanceManager.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/23/22.
//

import Foundation

enum ActionType {
    case add, remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(follower: Follower, actionType: ActionType, completed: @escaping(GFError?) -> Void) {
        getFavorites { result in
            switch result {
            case .success(var followers):
                switch actionType {
                case .add:
                    guard !followers.contains(follower) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    followers.append(follower)
                case .remove:
                    followers.removeAll {
                        $0.login == follower.login
                    }
                }
                completed(setFavorites(favorites: followers))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func getFavorites(completed: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func setFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch  {
            return .unableToFavorite
        }
    }
}

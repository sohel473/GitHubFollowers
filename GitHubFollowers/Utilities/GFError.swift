//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/20/22.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case noUsername = "No Username in git server exists. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    case unableToFavorite = "Unable to retreive favorites list data. Please try again"
    case alreadyInFavorites = "This user is already in fovorite list!"
}

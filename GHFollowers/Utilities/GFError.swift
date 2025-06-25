//
//  GFError.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 12/06/25.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again later."
    case unableToFavorite = "There was an error favoriting this user. Please try again later."
    case alreadyInFavorites = "This user is already in your favorites."
}

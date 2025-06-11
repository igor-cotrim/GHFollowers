//
//  Follower.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 11/06/25.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

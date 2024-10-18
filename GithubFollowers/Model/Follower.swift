//
//  Follower.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 16/10/24.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}

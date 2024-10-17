//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Hector Alonzo  on 17/10/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username creates an invalid URL"
    case unableToComplete = "Unable to complete the request, please check your internet connection"
    case invalidResponse = "The response from the server is invalid. Please try again later"
    case invalidData = "The data received from the server is invalid. Please try again later"
}

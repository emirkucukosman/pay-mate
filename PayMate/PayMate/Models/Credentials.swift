//
//  Credential.swift
//  PayMate
//
//  Created by Emir Küçükosman on 11.11.2020.
//

import Foundation

struct Credentials: Codable {
    let username: String
    let email: String?
    let password: String
}

enum AuthTaskType {
    case register
    case login
}

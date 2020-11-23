//
//  AccountResponse.swift
//  PayMate
//
//  Created by Emir Küçükosman on 24.11.2020.
//

import Foundation

struct AccountResponse: BaseResponse {
    var success: Bool
    var message: String
    let account: Account
}

struct Account: Codable {
    let username: String
    let balance: Float
}

//
//  LoginSuccessResponse.swift
//  PayMate
//
//  Created by Emir Küçükosman on 11.11.2020.
//

import Foundation

struct AuthResponse: BaseResponse {
    var success: Bool
    var message: String
    let token: String?
}

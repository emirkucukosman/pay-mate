//
//  ErrorResponse.swift
//  PayMate
//
//  Created by Emir Küçükosman on 24.11.2020.
//

import Foundation

struct ErrorResponse: BaseResponse {
    var success: Bool
    var message: String
}

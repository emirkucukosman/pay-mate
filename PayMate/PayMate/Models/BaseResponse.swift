//
//  BaseResponse.swift
//  PayMate
//
//  Created by Emir Küçükosman on 11.11.2020.
//

import Foundation

protocol BaseResponse: Codable {
    var success: Bool { get set }
    var message: String { get set }
}

//
//  PgyResponse.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/4.
//

import Foundation

struct PgyResponse<T: Decodable>: Decodable {
    var code: Int
    var data: T
    var message: String
}

//
//  ClientModel.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import Foundation

struct ClientModel {
    var id: UUID
    var name: String?
    var points: Int = 0
    var phoneNumber: String?
}

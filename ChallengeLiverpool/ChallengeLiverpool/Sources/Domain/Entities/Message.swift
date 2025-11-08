//
//  Message.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Foundation

struct Message: Identifiable {
    let id: String
    let senderId: String
    let text: String
    let timestamp: Date
}

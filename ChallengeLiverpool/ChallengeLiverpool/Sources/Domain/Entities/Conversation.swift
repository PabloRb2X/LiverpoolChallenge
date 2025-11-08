//
//  Conversation.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Foundation

struct Conversation: Identifiable {
    let id: String
    let participants: [String]
    let lastMessage: String
    let updatedAt: Date
}

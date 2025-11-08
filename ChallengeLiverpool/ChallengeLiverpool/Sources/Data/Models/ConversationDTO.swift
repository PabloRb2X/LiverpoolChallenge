//
//  ConversationDTO.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore

struct ConversationDTO: Codable {
    @DocumentID var id: String?
    let participants: [String]
    let lastMessage: String
    let updatedAt: Date

    func toDomain() -> Conversation {
        Conversation(
            id: id ?? "",
            participants: participants,
            lastMessage: lastMessage,
            updatedAt: updatedAt
        )
    }
}

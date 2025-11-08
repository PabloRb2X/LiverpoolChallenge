//
//  MessageDTO.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore

struct MessageDTO: Codable {
    @DocumentID var id: String?
    let senderId: String
    let text: String
    let timestamp: Date

    func toDomain() -> Message {
        Message(
            id: id ?? "",
            senderId: senderId,
            text: text,
            timestamp: timestamp
        )
    }

    static func fromDomain(_ message: Message) -> [String: Any] {
        [
            "senderId": message.senderId,
            "text": message.text,
            "timestamp": message.timestamp
        ]
    }
}

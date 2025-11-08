//
//  SendMessageUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

struct SendMessageUseCase {
    let repository: MessageRepository

    func execute(conversationId: String, message: Message) -> AnyPublisher<Void, Error> {
        repository.sendMessage(conversationId: conversationId, message: message)
    }
}

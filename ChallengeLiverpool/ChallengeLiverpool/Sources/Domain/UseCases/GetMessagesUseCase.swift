//
//  GetMessagesUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

struct GetMessagesUseCase {
    let repository: MessageRepository

    func execute(for conversationId: String) -> AnyPublisher<[Message], Error> {
        repository.getMessages(for: conversationId)
    }
}

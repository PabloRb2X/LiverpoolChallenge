//
//  GetConversationsUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

struct GetConversationsUseCase {
    let repository: ConversationRepository

    func execute(for userId: String) -> AnyPublisher<[Conversation], Error> {
        repository.getConversations(for: userId)
    }
}

//
//  ConversationRepository.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

protocol ConversationRepository {
    func getConversations(for userId: String) -> AnyPublisher<[Conversation], Error>
}

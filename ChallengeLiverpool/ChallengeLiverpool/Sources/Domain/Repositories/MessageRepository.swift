//
//  MessageRepository.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

protocol MessageRepository: AnyObject {
    func getMessages(for conversationId: String) -> AnyPublisher<[Message], Error>
    func sendMessage(conversationId: String, message: Message) -> AnyPublisher<Void, Error>
}

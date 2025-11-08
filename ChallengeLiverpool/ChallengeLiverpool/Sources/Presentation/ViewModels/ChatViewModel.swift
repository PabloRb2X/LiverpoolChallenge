//
//  ChatViewModel.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText = ""

    private let getMessagesUseCase: GetMessagesUseCase
    private let sendMessageUseCase: SendMessageUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getMessagesUseCase: GetMessagesUseCase, sendMessageUseCase: SendMessageUseCase) {
        self.getMessagesUseCase = getMessagesUseCase
        self.sendMessageUseCase = sendMessageUseCase
    }

    func observeMessages(for conversationId: String) {
        getMessagesUseCase.execute(for: conversationId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] messages in
                
                self?.messages = messages
            })
            .store(in: &cancellables)
    }

    func sendMessage(conversationId: String, senderId: String) {
        let message = Message(
            id: UUID().uuidString,
            senderId: senderId,
            text: newMessageText,
            timestamp: Date()
        )

        sendMessageUseCase.execute(conversationId: conversationId, message: message)
            .sink(receiveCompletion: { _ in }, receiveValue: { })
            .store(in: &cancellables)

        newMessageText = ""
    }
}

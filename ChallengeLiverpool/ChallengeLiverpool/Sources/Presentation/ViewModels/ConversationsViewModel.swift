//
//  ConversationsViewModel.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Foundation
import Combine

final class ConversationsViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var errorMessage: String?

    private let getConversationsUseCase: GetConversationsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getConversationsUseCase: GetConversationsUseCase) {
        self.getConversationsUseCase = getConversationsUseCase
    }

    func loadConversations(for userId: String) {
        getConversationsUseCase.execute(for: userId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] conversations in
                
                self?.conversations = conversations
            })
            .store(in: &cancellables)
    }
}

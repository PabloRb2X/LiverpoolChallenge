//
//  ConversationsView.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI

struct ConversationsView: View {
    @StateObject private var viewModel: ConversationsViewModel
    let userId: String

    init(userId: String, viewModel: ConversationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.userId = userId
    }

    var body: some View {
        NavigationView {
            List(viewModel.conversations) { conversation in
                NavigationLink(destination: ChatView(
                    chatViewModel: ChatViewModel(
                        getMessagesUseCase: GetMessagesUseCase(repository: MessageRepositoryImpl()),
                        sendMessageUseCase: SendMessageUseCase(repository: MessageRepositoryImpl())
                    ), conversationId: conversation.id,
                    currentUserId: userId
                )) {
                    VStack(alignment: .leading) {
                        Text(conversation.lastMessage)
                            .font(.body)
                        Text(conversation.updatedAt, style: .time)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Conversaciones")
            .onAppear {
                viewModel.loadConversations(for: userId)
            }
        }
    }
}

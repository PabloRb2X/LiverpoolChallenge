//
//  ChatView.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    let conversationId: String
    let currentUserId: String

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.messages) { msg in
                    HStack {
                        if msg.senderId == currentUserId {
                            Spacer()
                            Text(msg.text)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        } else {
                            Text(msg.text)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }

            HStack {
                TextField("Escribe un mensaje...", text: $chatViewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Enviar") {
                    chatViewModel.sendMessage(conversationId: conversationId, senderId: currentUserId)
                }
                .disabled(chatViewModel.newMessageText.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat")
        .onAppear {
            chatViewModel.observeMessages(for: conversationId)
        }
    }
}

//
//  RootView.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser {
                let conversationsViewModel = ConversationsViewModel(
                    getConversationsUseCase: GetConversationsUseCase(
                        repository: ConversationRepositoryImpl()
                    )
                )
                ConversationsView(userId: user.id, viewModel: conversationsViewModel)
                    .toolbar {
                        Button("Salir") {
                            viewModel.logout()
                        }
                    }
            } else {
                LoginView(viewModel: viewModel)
            }
        }
    }
}

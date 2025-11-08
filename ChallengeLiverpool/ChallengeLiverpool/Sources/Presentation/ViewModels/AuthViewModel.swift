//
//  AuthViewModel.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine
import SwiftUI

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var currentUser: AuthUser?
    @Published var errorMessage: String?

    private let loginUseCase: LoginUseCase
    private let registerUseCase: RegisterUseCase
    private let logoutUseCase: LogoutUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        loginUseCase: LoginUseCase,
        registerUseCase: RegisterUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.registerUseCase = registerUseCase
        self.logoutUseCase = logoutUseCase
    }

    func login() {
        loginUseCase.execute(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] user in
                    
                    self?.currentUser = user
                }
            )
            .store(in: &cancellables)
    }
    
    func register() {
        registerUseCase.execute(email: email, password: password, username: username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] user in
                    self?.currentUser = user
                }
            )
            .store(in: &cancellables)
    }

    func logout() {
        logoutUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    self?.errorMessage = nil
                    self?.currentUser = nil
                }
            )
            .store(in: &cancellables)
    }
}

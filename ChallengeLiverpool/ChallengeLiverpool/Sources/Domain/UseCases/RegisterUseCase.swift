//
//  RegisterUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

struct RegisterUseCase {
    let repository: AuthRepository

    func execute(email: String, password: String, username: String) -> AnyPublisher<AuthUser, Error> {
        repository.register(email: email, password: password, username: username)
    }
}

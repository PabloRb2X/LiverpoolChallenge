//
//  LoginUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

struct LoginUseCase {
    let repository: AuthRepository

    func execute(email: String, password: String) -> AnyPublisher<AuthUser, Error> {
        repository.login(email: email, password: password)
    }
}

//
//  LogoutUseCase.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//
import Combine

struct LogoutUseCase {
    let repository: AuthRepository

    func execute() -> AnyPublisher<Void, Error> {
        repository.logout()
    }
}

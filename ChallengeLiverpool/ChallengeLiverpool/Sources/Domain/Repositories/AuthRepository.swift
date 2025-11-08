//
//  AuthRepository.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

protocol AuthRepository {
    func login(email: String, password: String) -> AnyPublisher<AuthUser, Error>
    func register(email: String, password: String, username: String) -> AnyPublisher<AuthUser, Error>
    func logout() -> AnyPublisher<Void, Error>
    func getCurrentUser() -> AuthUser?
}

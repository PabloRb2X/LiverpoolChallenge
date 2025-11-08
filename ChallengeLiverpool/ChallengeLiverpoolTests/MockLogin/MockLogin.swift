//
//  MockLogin.swift
//  ChallengeLiverpool
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Foundation
import Combine
@testable import ChallengeLiverpool

struct MockAuthRepository: AuthRepository {
    var shouldSucceed = true
    var userToReturn = AuthUser(id: "123", email: "test@example.com")

    func login(email: String, password: String) -> AnyPublisher<AuthUser, Error> {
        if shouldSucceed {
            return Just(userToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "LoginError", code: 1))
                .eraseToAnyPublisher()
        }
    }

    func register(email: String, password: String, username: String) -> AnyPublisher<AuthUser, Error> {
        if shouldSucceed {
            return Just(userToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "RegisterError", code: 1))
                .eraseToAnyPublisher()
        }
    }

    func logout() -> AnyPublisher<Void, Error> {
        if shouldSucceed {
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "LogoutError", code: 1))
                .eraseToAnyPublisher()
        }
    }
    
    func getCurrentUser() -> AuthUser? {
        nil
    }
}

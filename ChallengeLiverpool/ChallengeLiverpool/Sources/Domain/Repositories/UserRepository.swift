//
//  UserRepository.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import Combine

protocol UserRepository {
    func getUser(uid: String) -> AnyPublisher<User, Error>
    func updateUser(user: User) -> AnyPublisher<Void, Error>
}

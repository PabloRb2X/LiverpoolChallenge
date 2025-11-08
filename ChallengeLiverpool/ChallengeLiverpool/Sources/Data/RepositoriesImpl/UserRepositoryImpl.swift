//
//  UserRepositoryImpl.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore
import Combine

final class UserRepositoryImpl: UserRepository {
    private let db = Firestore.firestore()
    private let usersCollection = "users"

    func getUser(uid: String) -> AnyPublisher<User, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            self.db.collection(self.usersCollection).document(uid).getDocument { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                do {
                    if let data = try snapshot?.data(as: UserDTO.self) {
                        promise(.success(data.toDomain()))
                    } else {
                        promise(.failure(NSError(domain: "User not found", code: 404)))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func updateUser(user: User) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            let data: [String: Any] = [
                "email": user.email,
                "username": user.username,
                "photoURL": user.photoURL ?? ""
            ]
            
            self.db.collection(self.usersCollection).document(user.id).setData(data, merge: true) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
}

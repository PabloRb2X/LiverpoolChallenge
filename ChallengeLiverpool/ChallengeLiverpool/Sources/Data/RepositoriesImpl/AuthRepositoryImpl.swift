//
//  AuthRepositoryImpl.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseAuth
import FirebaseFirestore
import Combine

final class AuthRepositoryImpl: AuthRepository {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()

    func login(email: String, password: String) -> AnyPublisher<AuthUser, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            self.auth.signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    
                    promise(.failure(error))
                } else if let user = result?.user {
                    
                    promise(.success(AuthUser(id: user.uid, email: user.email ?? "")))
                }
            }
        }.eraseToAnyPublisher()
    }

    func register(email: String, password: String, username: String) -> AnyPublisher<AuthUser, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            self.auth.createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    
                    promise(.failure(error))
                } else if let user = result?.user {
                    let newUser = [
                        "email": email,
                        "username": username,
                        "photoURL": "",
                        "createdAt": Timestamp(date: Date())
                    ] as [String: Any]

                    self.db.collection("users").document(user.uid).setData(newUser) { err in
                        if let err = err {
                            
                            promise(.failure(err))
                        } else {
                            
                            promise(.success(AuthUser(id: user.uid, email: email)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                try self.auth.signOut()
                
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func getCurrentUser() -> AuthUser? {
        guard let user = auth.currentUser else { return nil }
        
        return AuthUser(id: user.uid, email: user.email ?? "")
    }
}

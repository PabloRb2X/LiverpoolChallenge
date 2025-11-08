//
//  UserDTO.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore

struct UserDTO: Codable {
    @DocumentID var id: String?
    let email: String
    let username: String
    let photoURL: String?

    func toDomain() -> User {
        User(id: id ?? "", email: email, username: username, photoURL: photoURL)
    }
}

//
//  ConversationRepositoryImpl.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore
import Combine

final class ConversationRepositoryImpl: ConversationRepository {
    private let db = Firestore.firestore()

    func getConversations(for userId: String) -> AnyPublisher<[Conversation], Error> {
        let subject = PassthroughSubject<[Conversation], Error>()
        
        db
            .collection("conversations")
            .whereField("participants", arrayContains: userId)
            .order(by: "updatedAt", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    
                    subject.send(completion: .failure(error))
                } else if let documents = snapshot?.documents {
                    
                    let conversations = documents.compactMap {
                        try? $0.data(as: ConversationDTO.self).toDomain()
                    }
                    subject.send(conversations)
                }
            }
        
        return subject.eraseToAnyPublisher()
    }
}

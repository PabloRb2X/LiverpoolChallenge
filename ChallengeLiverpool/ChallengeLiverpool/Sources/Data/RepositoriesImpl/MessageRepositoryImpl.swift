//
//  MessageRepositoryImpl.swift
//  LiverpoolChallenge
//
//  Created by Pablo Ramirez on 07/11/25.
//

import FirebaseFirestore
import Combine

final class MessageRepositoryImpl: MessageRepository {
    private let db = Firestore.firestore()

    func getMessages(for conversationId: String) -> AnyPublisher<[Message], Error> {
        let subject = PassthroughSubject<[Message], Error>()
        
        db
            .collection("conversations")
            .document(conversationId)
            .collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    
                    subject.send(completion: .failure(error))
                } else if let documents = snapshot?.documents {
                    
                    let messages = documents.compactMap {
                        try? $0.data(as: MessageDTO.self).toDomain()
                    }
                    
                    subject.send(messages)
                }
            }
        
        return subject.eraseToAnyPublisher()
    }

    func sendMessage(conversationId: String, message: Message) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            
            let data = MessageDTO.fromDomain(message)
            
            self.db
                .collection("conversations")
                .document(conversationId)
                .collection("messages")
                .addDocument(data: data) { error in
                    if let error = error {
                        
                        promise(.failure(error))
                    } else {
                        
                        self.db
                            .collection("conversations").document(conversationId)
                            .updateData([
                                "lastMessage": message.text,
                                "updatedAt": message.timestamp
                            ]) { _ in }
                        
                        promise(.success(()))
                    }
                }
        }.eraseToAnyPublisher()
    }
}

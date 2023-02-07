//
//  FirestoreManager.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    private init() {}
    
    func getUser(by id: String, completion: @escaping(Client) -> ()) {
        let docRef = db.collection("users").document(id)
        
        docRef.getDocument(as: Client.self) { result in
            switch result {
            case .success(let person):
                completion(person)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveUser(_ user: Client) {
        db.collection("users").document(user.id).setData([
            "email": user.email,
            "id": user.id,
            "favoriteCharactersID": user.favoriteCharactersID
        ]) { error in
            if let error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(user.id)")
            }
        }
    }
    
    func saveCharacterToFavorites(with id: Int, to client: Client) {
        db.collection("users").document(client.id).updateData([
            "favoriteCharactersID": FieldValue.arrayUnion([id])
        ])
    }
    
    func deleteCharacterFromFavorites(with id: Int, from client: Client) {
        db.collection("users").document(client.id).updateData([
            "favoriteCharactersID": FieldValue.arrayRemove([id])
        ])
    }
}

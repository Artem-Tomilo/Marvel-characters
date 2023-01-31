//
//  FirestoreManager.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation
import FirebaseFirestore

//class FirestoreManager {
//    
//    private let db = Firestore.firestore()
//    private var ref: DocumentReference?
//    
//    func getUsers() {
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//    }
//    
//    func saveUser(_ user: User) {
//        ref = db.collection("users").addDocument(data: [
//            "email": user.email,
//            "id": user.id
//        ]) { error in
//            if let error {
//                print("Error adding document: \(error)")
//            } else {
//                print("Document added with ID: \(self.ref!.documentID)")
//            }
//        }
//
//    }
//}

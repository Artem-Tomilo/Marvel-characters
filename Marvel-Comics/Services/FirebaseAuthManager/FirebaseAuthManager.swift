//
//  FirebaseAuthManager.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class FirebaseAuthManager {

    func createUser(email: String, password: String, completion: @escaping (Result<Void, BaseError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard authResult != nil else { return }
            completion(.success(()))
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Void, BaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard authResult != nil else { return }
            completion(.success(()))
        }
    }
    
    func signInWithGoogle(view: UIViewController, completion: @escaping (Result<Void, BaseError>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { signInResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard signInResult != nil else { return }
            completion(.success(()))
        }
    }
}

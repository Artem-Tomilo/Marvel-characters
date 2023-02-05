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

final class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    private init() {}

    func createUser(email: String, password: String, completion: @escaping (Result<User, BaseError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard let authResult else { return }
            completion(.success((authResult.user)))
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, BaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard let authResult else { return }
            completion(.success((authResult.user)))
        }
    }
    
    func signInWithGoogle(view: UIViewController, completion: @escaping (Result<GIDGoogleUser, BaseError>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { signInResult, error in
            if let error {
                completion(.failure(BaseError(message: error.localizedDescription)))
            }
            guard let signInResult else { return }
            completion(.success((signInResult.user)))
        }
    }
}

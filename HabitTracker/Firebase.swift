//
//  Firebase.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/18/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation
import Firebase

class Firebase {
    // MARK: - Properties
    static let shared = Firebase()
    var currentUser: User?
    
    // MARK: - Signing In
    func initialAnonymouslySignIn() {
        Auth.auth().signInAnonymously { (auth, error) in
            if let error = error {
                print("❌Error anonymously signing in: \(error), \(error.localizedDescription)")
            }
            guard let user = auth?.user else { return }
            let uid = user.uid
            self.currentUser = User(uuid: uid)
        }
    }
    
    func createAPermenantAccount(email: String, password: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("❌Error creating an account: \(error) \(error.localizedDescription)")
            }
            guard let user = auth?.user else { return }
            user.linkAndRetrieveData(with: credential, completion: { (auth, error) in
                if let error = error {
                    print("❌Error linking accounts: \(error) \(error.localizedDescription)")
                }
                guard let user = auth?.user else { return }
                let uid = user.uid
                self.currentUser = User(uuid: uid)
            })
        }
    }
    
    func signInAUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("❌Error signing in accounts: \(error) \(error.localizedDescription)")
            }
            guard let user = auth?.user else { return }
            let uid = user.uid
            self.currentUser = User(uuid: uid)
        }
    }
}

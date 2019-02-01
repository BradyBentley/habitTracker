//
//  UserController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/22/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    // MARK: - Properties
    static let shared = UserController()
    var currentUser: User?
    
    // MARK: - CRUD
    func createUser(email: String, password: String, completion: @escaping SuccessCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("❌Error creating a user: \(error) \(error.localizedDescription)")
                completion(false)
            }
            guard let uuid = auth?.user.uid else { completion(false) ; return }
            self.currentUser = User(uuid: uuid)
            completion(true)
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping SuccessCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("❌Error signing a user in: \(error) \(error.localizedDescription)")
                completion(false)
            }
            guard let uuid = auth?.user.uid else { completion(false) ; return }
            self.currentUser = User(uuid: uuid)
            completion(true)
        }
    }
    
    func signOutUser(completion: @escaping SuccessCompletion){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

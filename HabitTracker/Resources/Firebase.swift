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
    let firestore = Firestore.firestore()
    var ref:DocumentReference?
    
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
    
    func saveHabit(habit: Habit, completion: @escaping successCompletion) {
        guard let currentUser = currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).addDocument(data: habit.dictionary)
        completion(true)
    }
    
    func fetchHabits(completion: @escaping successCompletion) {
        guard let currentUser = currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).getDocuments { (query, error) in
            if let error = error {
                print("Error fetching data: \(error) \(error.localizedDescription)")
            }
            guard let documents = query?.documents else { completion(false) ; return }
            let habits = documents.compactMap{ Habit(firebaseDictionary: $0.data()) }
            HabitController.shared.habits = habits
            completion(true)
        }
    }
    
    func updateHabitOnFirebase(habit: Habit, isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, completion: @escaping successCompletion) {
        guard let currentUser = currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document().updateData(habit.dictionary)
        completion(true)
    }
    
    func deleteHabit(habit: Habit, completion: @escaping successCompletion) {
        guard let currentUser = currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document().delete()
        completion(true)
    }
}

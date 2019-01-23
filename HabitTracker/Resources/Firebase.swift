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
    let firestore = Firestore.firestore()
    var ref:DocumentReference?
    
    // MARK: - CRUD
    func saveHabit(habit: Habit, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).setData(habit.dictionary)
    }
    
    func fetchHabits(completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
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
    
    func updateHabitOnFirebase(habit: Habit, habitDescription: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).setData([Habit.habitKeys.habitDescriptionKey: habitDescription, Habit.habitKeys.daysKey: days, Habit.habitKeys.weeksKey: weeks])
        completion(true)
    }
    
    func deleteHabit(habit: Habit, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).delete()
        completion(true)
    }
}

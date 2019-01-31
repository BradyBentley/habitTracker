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
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.setData(habit.dictionary)
        completion(true)
    }
    
    func fetchHabits(completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).getDocuments { (query, error) in
            if let error = error {
                print("Error fetching data: \(error) \(error.localizedDescription)")
                completion(false)
            }
            guard let documents = query?.documents else { completion(false) ; return }
            let habits = documents.compactMap{ Habit(firebaseDictionary: $0.data())}
            HabitController.shared.habits = habits
            completion(true)
        }
    }
    
    func updateHabitOnFirebase(habit: Habit, habitDescription: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        print(habit.habitDescription)
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.habitDescriptionKey: habitDescription,
                           Habit.habitKeys.daysKey: days,
                           Habit.habitKeys.weeksKey: weeks
            ])
        completion(true)
    }
    
    func createTimeReminders(habit: Habit, timeReminder: TimeReminder, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.timeReminderKey: FieldValue.arrayUnion([timeReminder.uuid])])
        let timeRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.timeReminderKey).document(timeReminder.uuid)
        timeRef.setData(timeReminder.dictionary)
        completion(true)
    }
    
    func fetchTimeReminder(timeReminderUUID: [String], completion: @escaping ([TimeReminder]) -> Void) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion([]) ; return }
        
        var timeReminders: [TimeReminder] = []
        for uuid in timeReminderUUID {
            let timeRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.timeReminderKey).document(uuid)
            timeRef.getDocument { (document, error) in
                if let error = error {
                    print("Error fetching Time Reminders: \(error) \(error.localizedDescription)")
                    completion([])
                }
                guard let document = document?.data(),
                    let timeReminder = TimeReminder(firebaseDictionary: document) else { completion([]) ; return }
                timeReminders.append(timeReminder)
                completion(timeReminders)
            }
        }
    }
    
    func updateTimeReminder(habit: Habit, timeReminder: TimeReminder, reminderText: String, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let timeRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.timeReminderKey).document(timeReminder.uuid)
        timeRef.updateData(["reminderText": reminderText])
        completion(true)
    }
    
    func deleteTimeReminder(habit: Habit, timeReminder: TimeReminder, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.timeReminderKey: FieldValue.arrayRemove([timeReminder.uuid])])
        let timeRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.timeReminderKey).document(timeReminder.uuid)
        timeRef.delete()
        completion(true)
    }
    
    func createLocationReminder(habit: Habit, locationReminder: LocationReminder, completion: @escaping SuccessCompletion){
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.locationReminderKey: FieldValue.arrayUnion([locationReminder.uuid])])
        let locRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.locationReminderKey).document(locationReminder.uuid)
        locRef.setData(locationReminder.dictionary)
        completion(true)
    }
    
    func fetchLocationReminders(locationReminderUUID: [String], completion: @escaping ([LocationReminder]) -> Void) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion([]) ; return }
        
        var locationReminders: [LocationReminder] = []
        for uuid in locationReminderUUID {
            let locRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.locationReminderKey).document(uuid)
            locRef.getDocument { (document, error) in
                if let error = error {
                    print("Error fetching Location Reminders: \(error) \(error.localizedDescription)")
                    completion([])
                }
                guard let document = document?.data(),
                    let locationReminder = LocationReminder(firebaseDictionary: document) else { completion([]) ; return }
                locationReminders.append(locationReminder)
                completion(locationReminders)
            }
            
        }
    }
    
    func updateLocationReminders(habit: Habit, locationReminder: LocationReminder, reminderText: String, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let locationRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.locationReminderKey).document(locationReminder.uuid)
        locationRef.updateData(["reminderText": reminderText])
        completion(true)
    }
    
    func deleteLocationReminder(habit: Habit, locationReminder: LocationReminder, completion: @escaping SuccessCompletion){
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.locationReminderKey: FieldValue.arrayRemove([locationReminder.uuid])])
        let locationRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.locationReminderKey).document(locationReminder.uuid)
        locationRef.delete()
        completion(true)
    }
    
    func deleteHabit(habit: Habit, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.delete()
        completion(true)
    }
    
    func updateCompletePercent(habit: Habit, completePercent: [Double], completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.completionPercent: habit.completionPercent])
        completion(true)
    }
    
    func updateDaysCheckedIn(habit: Habit, daysCheckedIn: Int, completion: @escaping SuccessCompletion) {
        guard let currentUser = UserController.shared.currentUser?.uuid else { completion(false) ; return }
        let docRef = firestore.collection(Habit.habitKeys.userKey).document(currentUser).collection(Habit.habitKeys.habitsKey).document(habit.habitDescription)
        docRef.updateData([Habit.habitKeys.daysCheckedInKey: daysCheckedIn])
        completion(true)
    }
}

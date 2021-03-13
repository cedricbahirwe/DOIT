//
//  LocalStorage.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation


let TODO_USER = "TODO_USER"
let TODO_USER_LOGIN = "TODO_USER_LOGIN"
let STORED_EVENTS = "CACHED_EVENTS"


class TODOSession {
    
    private init() {}
    static let shared = TODOSession()
    let userDefaults = UserDefaults.standard
    
    
    // MARK:- Properties
    // Check if the user is logged in
    var isLoggedIn : Bool {
        get {
            return userDefaults.bool(forKey: TODO_USER_LOGIN)
        }
        set (value){
            userDefaults.set(value, forKey: TODO_USER_LOGIN)
        }
    }
    
    var storedTasks: [StoredTaskModel]? {
        get{
            guard let tasks = UserDefaults.standard.object(forKey: STORED_EVENTS) as? Data else { return [] }

            return try? JSONDecoder().decode([StoredTaskModel].self, from: tasks)
        }
        set(tasks){
            if let encoded = try? JSONEncoder().encode(tasks){
                UserDefaults.standard.set(encoded, forKey: STORED_EVENTS)
            }
        }
    }
    
    var toDoUser: TODOUserModel? {
        get{
            guard let user = UserDefaults.standard.object(forKey: TODO_USER) as? Data else { return nil }

            return try? JSONDecoder().decode(TODOUserModel.self, from: user)
        }
        set(user){
            if let encoded = try? JSONEncoder().encode(user){
                UserDefaults.standard.set(encoded, forKey: TODO_USER)
            }
        }
    }
    
    // This method is used to destroy a session
    func destroy() {
        // MARK: MAIN OBJECTS TO REMOVE ON LOG OUT
        UserDefaults.standard.removeObject(forKey: TODO_USER_LOGIN)
        
        // MARK:
        UserDefaults.standard.removeObject(forKey: TODO_USER)
        UserDefaults.standard.removeObject(forKey: STORED_EVENTS)
    }
    
}

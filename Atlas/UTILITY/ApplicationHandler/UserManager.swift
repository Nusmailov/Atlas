//
//  UserManager.swift
//  JTI
//
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation
class UserManager {

    //    MARK: - Properties
    static let shared = UserManager()
    private let userDefaults = UserDefaults.standard

    //    MARK: - Keys
    private let deviceTokenIdentifier = "deviceTokenIdentifier"
    private let userIdentifier = "userIdentifier"

    private init() {}

    //    MARK: - Creation of user session

    func createSession(withUser user: User) {
        let encoder = JSONEncoder()
        if let userData = try? encoder.encode(user) {
            userDefaults.set(userData, forKey: userIdentifier)
            userDefaults.synchronize()
        } else {
            print("can't save user session")
        }
    }

    //    MARK: - Receive current user

    func getCurrentUser() -> User? {
        let decoder = JSONDecoder()

        if let data = userDefaults.data(forKey: userIdentifier) {
            if let user = try? decoder.decode(User.self, from: data) {
                return user
            }
        }

        return nil
    }

    //    MARK: - Session active

    func isSessionActive() -> Bool {
        return getCurrentUser() != nil
    }

    func deleteCurrentSession() {
        userDefaults.set(nil, forKey: userIdentifier)
        userDefaults.set(nil, forKey: deviceTokenIdentifier)
        userDefaults.synchronize()
    }
}

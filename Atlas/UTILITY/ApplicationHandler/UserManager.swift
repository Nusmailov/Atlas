//
//  UserManager.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 8/16/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

class UserManager {
    static let userDefaults = UserDefaults.standard
    
    static func createSessionWithUser(_ user: User) throws {
        let jsonEncoder = JSONEncoder()
        do {
            let userData = try jsonEncoder.encode(user)
            setCurrentToken(to: user.token)
            userDefaults.set(userData, forKey: Key.currentUser)
        } catch {
            throw error
        }
    }
    
    private static func setCurrentToken(to token: String) {
        userDefaults.set(token, forKey: Key.currentToken)
    }
    
    static func getCurrentToken() -> String? {
        return userDefaults.string(forKey: Key.currentToken)
    }
    
    static func getCurrentUser() -> User? {
        let jsonDecoder = JSONDecoder()
        if let userData = userDefaults.value(forKey: Key.currentUser) as? Data {
            do {
                let currentUser = try jsonDecoder.decode(User.self, from: userData)
                return currentUser
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
//    static func updateUserData(forToken token: String, completion: @escaping (Result<User>) -> ()) {
//        let endpoint = Endpoints.auth(token: token)
//        let networkManager = Router(parser: CustomParser())
//        networkManager.request(endpoint) { (result: Result<SignInModel>) in
//            completion(result)
//        }
//    }
    
    static func deleteCurrentSession() {
        userDefaults.set(nil, forKey: Key.currentToken)
        userDefaults.set(nil, forKey: Key.currentUser)
    }
}

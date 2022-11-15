//
//  LoginViewModel.swift
//  FoodSaver
//
//  Created on 01/10/22.
//

import Foundation

class LoginViewModel {
    
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func doLogin(completion: @escaping(Error?) -> ()) {
        validate { (error) in
            guard error == nil else {
                return completion(error)
            }
            
            guard let account = DBManager.manager.accountForUsername(username: self.username.value)  else {
                return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("User not available.", comment: "User not available.")]))
            }
            
            if account.password == self.password.value {
                AppManager.manager.loginAccount = account
                return completion(nil)
            }
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Please enter correct password.", comment: "Please enter correct password.")]))
        }
    }
    
    func validate(completion: @escaping(Error?) -> ()) {
        guard username.value.isEmpty == false else {
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Username should not be empty. Please enter.", comment: "Username should not be empty. Please enter.")]))
        }
        
        guard password.value.isEmpty == false else {
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Password should not be empty. Please enter.", comment: "Password should not be empty. Please enter.")]))
        }
        completion(nil)
    }
}
 

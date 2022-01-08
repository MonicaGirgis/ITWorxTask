//
//  UserManager.swift
//  FaceDoct
//
//  Created by Mina Malak on 21/06/2021.
//

import Foundation

class UserManager{
    
    public static let shared = UserManager()
    private init(){}
    
    func setData(){
        UserDefaults.standard.set("", forKey: "userName")
    }
    
    func getUserName() -> String?{
        return UserDefaults.standard.string(forKey: "userName")
    }
    
    func setAuthenticationKey(key: String){
        let authorizationKey = "bearer " + key
        UserDefaults.standard.set(authorizationKey, forKey: "authorizationKey")
    }
    
    func getAuthorizationKey() -> String?{
        return UserDefaults.standard.string(forKey: "authorizationKey")
    }
    
    func clearData(){
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "authorizationKey")
    }
}

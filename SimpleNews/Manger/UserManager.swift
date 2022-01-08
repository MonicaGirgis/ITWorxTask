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
        UserDefaults.standard.set(true, forKey: "FirstLaunch")
    }
    
    func userDidFirstLaunch() -> Bool?{
        return UserDefaults.standard.bool(forKey: "FirstLaunch")
    }
    
    func clearData(){
        UserDefaults.standard.removeObject(forKey: "FirstLaunch")
    }
}

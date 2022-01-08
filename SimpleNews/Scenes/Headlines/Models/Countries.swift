//
//  Countries.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import Foundation

enum Countries{
    case UnitedStates
    
    var code: String{
        switch self{
        case .UnitedStates:
            return "us"
        }
    }
}

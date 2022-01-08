//
//  SimpleNews.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 06/01/2022.
//

import Foundation

enum SimpleNews{
    case GetData
}

extension SimpleNews: Endpoint{
    var base: String {
        return Bundle.main.baseURL
    }
    
    var urlSubFolder: String {
        return Bundle.main.urlSubFolder
    }
    
    var path: String {
        switch self{
        case .GetData:
            return "main"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var params: [URLQueryItem] = []
        params.append(URLQueryItem(name: "apiKey", value: "291fe5f954674cf9bd005c09f389ce70"))
        
        switch self{
        case .GetData:
            params.append(URLQueryItem(name: "", value: ""))
        }
        return params
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var body: [String: Any]?{
        return nil
    }
    
}


extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "URLSubFolder") as? String ?? ""
    }
}

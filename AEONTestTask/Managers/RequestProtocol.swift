//
//  RequestProtocol.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

enum AddressesURLs: String {
    case login = "http://82.202.204.94/api-test/login"
    case payments = "http://82.202.204.94/api-test/payments"
}

protocol RequestProtocol {
    func signinRequest(login: String, password: String) -> URLRequest
}

extension RequestProtocol {
    
    func signinRequest(login: String, password: String) -> URLRequest {
        let url = URL(string: AddressesURLs.login.rawValue)!
        var request = URLRequest(url: url)
        
        let logPass = Signin(login: login, password: password)
        let encoder = JSONEncoder()
        let data = try? encoder.encode(logPass)
        
        let header = [
            "app-key" : "12345",
            "v" : "1"
        ]
        
        if let data = data {
            request.httpBody = data
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = header
        }
        
       return request
    }
}

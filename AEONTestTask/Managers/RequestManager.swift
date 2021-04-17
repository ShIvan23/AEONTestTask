//
//  RequestManager.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

protocol RequestProtocol {
    func signinRequest() -> URLRequest
}

extension RequestProtocol {
    
    func signinRequest() -> URLRequest {
        let url = URL(string: "http://82.202.204.94/api-test/login")!
        var request = URLRequest(url: url)
        
        let logPass = Signin(login: "demo", password: "12345")
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

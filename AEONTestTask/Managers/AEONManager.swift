//
//  AEONManager.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

final class AEONManager: RequestProtocol, APIProtocol {
    
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    convenience init() {
        self.init(sessionConfiguration: URLSessionConfiguration.default)
    }
    
    func signin(login: String, password: String, completion: @escaping (Result<Objects, Error>) -> Void) {
        let request = signinRequest()
        fetch(request: request, completionHandler: completion)
    }
    
    
}

//
//  Login.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

struct Login: Codable {
    var success: String
    var response: Response
    
    
    struct Response: Codable {
        var token: String
    }
}

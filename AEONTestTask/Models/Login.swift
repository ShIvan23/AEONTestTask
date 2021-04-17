//
//  Login.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import Foundation

struct Login: Decodable {
    var success: String
    var response: Response
    
    
    struct Response: Decodable {
        var token: String
    }
}

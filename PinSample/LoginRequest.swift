//
//  LoginRequest.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: UdacityCredentials
    
    init(username: String, password: String) {
        udacity = UdacityCredentials(username: username, password: password)
    }
}

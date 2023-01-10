//
//  UserDataResponse.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation

struct UserDataResponse: Codable {
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
    }
}

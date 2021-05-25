//
//  UserID.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

class UserID: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

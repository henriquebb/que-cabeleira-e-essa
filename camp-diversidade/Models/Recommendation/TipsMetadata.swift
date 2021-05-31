//
//  TipsMetadata.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct TipsMetadata: Decodable {
    public var total: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case total
    }
}

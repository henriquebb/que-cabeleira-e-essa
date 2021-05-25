//
//  Tips.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Tips: Decodable {
    var metadata: TipsMetadata
    var data: [Tip] = []
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
}

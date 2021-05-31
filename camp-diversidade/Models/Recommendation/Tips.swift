//
//  Tips.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Tips: Decodable {
    public var metadata: TipsMetadata
    public var data: [Tip] = []
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
}

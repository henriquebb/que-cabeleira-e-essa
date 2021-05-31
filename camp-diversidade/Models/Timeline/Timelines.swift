//
//  Timelines.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class Timelines: Decodable {
    public var metadata: TimelineMetadata
    public var data: [Timeline]
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
}

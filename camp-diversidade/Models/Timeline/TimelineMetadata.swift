//
//  TimelineMetadata.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class TimelineMetadata: Decodable {
    public var total: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case total
    }
}
